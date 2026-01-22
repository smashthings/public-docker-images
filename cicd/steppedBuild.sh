#!/usr/bin/env bash
set -u
# set -x
# steppedBuild.sh
#
# Cycles through each of the build directories in their dependency order
# Runs the given command via 'eval' in each directory, any failures will stop the run, any successes will continue on

########################################
# CONFIG: define your sets here
########################################

# Human-friendly names for sets (same order as SetDirs)
SetNames=(
  "base"
  "main"
  "docker"
  "frontend"
)

# Each element is a whitespace-separated list of directories for that set.
# Tip: keep paths simple (no spaces). If you need spaces, refactor to use arrays-per-set.
SetDirs=(
  "base-image/"
  "backup/ docker/ flask-waitress/ solidjs/"
  "debug/"
  "go-dev/ python-fe/ hugo/"
)

########################################
# CLI parsing
########################################

StartSet=1
RunningCommand='docker compose build'
NumSets=${#SetNames[@]}

usage() {
  cat <<'EOF'
Usage:
  steppedBuild.sh [--start-set N] -- <command> [args...]

Examples:
  ./steppedBuild.sh -c 'make test'
  ./steppedBuild.sh --start-set 2 --cmd 'npm test'
EOF
}

if [[ $# -eq 0 ]]; then usage; exit 2; fi

while [[ $# -gt 0 ]]; do
  case "$1" in
    --start-set)
      if [[ $2 -ge $NumSets ]]; then
        echo "ERROR: --start-set requires the set number to be valid, total sets: ${NumSets}, got: ${2}"
        usage
        exit 2
      fi
      StartSet="$2"
      shift 2
      ;;
    --cmd|-c)
      RunningCommand="$2"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: unknown argument ${1}"
      usage
      exit 2
      ;;
  esac
done

if ! [[ "$StartSet" =~ ^[0-9]+$ ]] || (( StartSet < 1 || StartSet > NumSets )); then
  echo "ERROR: --start-set must be between 1 and $NumSets"
  exit 2
fi

########################################
# State tracking + final reporting
########################################

SuccessDirs=()
FailedDirs=()
ExitCode=0

PrintJumpHints() {
  echo
  echo "Jump to a set with: --start-set N"
  echo "Available sets:"
  local i
  for ((i=1; i<=NumSets; i++)); do
    echo "  $i) ${SetNames[i-1]}"
  done
}

ReportAndExit() {
  local code="$1"
  echo
  echo "========== Summary =========="
  if (( ${#SuccessDirs[@]} > 0 )); then
    echo "Successful directories so far:"
    printf '  %s\n' "${SuccessDirs[@]}"
  else
    echo "Successful directories so far: (none)"
  fi

  if (( ${#FailedDirs[@]} > 0 )); then
    echo
    echo "Failures in current set:"
    printf '  %s\n' "${FailedDirs[@]}"
  fi

  PrintJumpHints
  echo "============================="
  exit "$code"
}

trap 'ReportAndExit "$ExitCode"' EXIT

########################################
# Runner
########################################

RunInDir() {
  local dir="$1"
  if [[ ! -d "$dir" ]]; then
    echo "[FAIL] $dir (not a directory)"
    return 1
  fi

  echo "[RUN ] $dir: ${RunningCommand[*]}"
  ( cd "$dir" && eval "${RunningCommand}" )
}

for ((SetInd=StartSet; SetInd<=NumSets; SetInd++)); do
  FailedDirs=()

  SetName="${SetNames[SetInd-1]}"
  SetDirs="${SetDirs[SetInd-1]}"

  echo
  echo "===== Set $SetInd/$NumSets: $SetName ====="

  # shellcheck disable=SC2206
  dirs=( $SetDirs )

  for dir in "${dirs[@]}"; do
    if RunInDir "$dir"; then
      SuccessDirs+=( "$dir" )
    else
      FailedDirs+=( "$dir" )
    fi
  done

  if (( ${#FailedDirs[@]} > 0 )); then
    echo
    echo "Set '$SetName' had failures; stopping before next set."
    ExitCode=1
    exit 1
  fi

  echo "Set '$SetName' completed successfully."
done

ExitCode=0
exit 0

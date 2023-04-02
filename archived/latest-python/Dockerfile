FROM smasherofallthings:base-image
LABEL maintainer="smasherofallthings"
LABEL description="Installing the latest version of python on top of a chosen Debian release - more details: https://gitlab.com/scripteddog/public-docker-images"

COPY artefacts/installPython.sh /opt/python3

RUN bash /opt/python3/installPython.sh


ENV LANG C.UTF-8

ENV PYTHON_PIP_VERSION %%PLACEHOLDER%%
# https://github.com/pypa/get-pip
ENV PYTHON_GET_PIP_URL %%PLACEHOLDER%%
ENV PYTHON_GET_PIP_SHA256 %%PLACEHOLDER%%z


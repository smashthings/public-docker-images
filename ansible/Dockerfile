ARG BaseImage
FROM ${BaseImage}

LABEL maintainer="smasherofallthings"
LABEL description="A general ansible image containing standard ansible build tools - more details: https://gitlab.com/scripteddog/public-docker-images"

RUN python3 -m pip install \
  ansible \
  kubernetes \
  boto3 \
  psycopg2-binary \
  PyMySQL

RUN apt install docker-cli docker-compose -y

CMD ["/bin/bash"]
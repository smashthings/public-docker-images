FROM smasherofallthings/base-image:latest

RUN apt-get update && apt-get install -y \
python3 \
python3-pip \
bash 

RUN python3 -m pip install \
requests \
awscli \
PyYaml \
names \
jmespath \
Jinja2 \
boto3 \
bitstring \
Flask \
waitress

ENTRYPOINT [ "python3" ]
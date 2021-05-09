FROM smasherofallthings:base-image

COPY artefacts/installPython.sh /opt/python3

RUN bash /opt/python3/installPython.sh


ENV LANG C.UTF-8

ENV PYTHON_PIP_VERSION %%PLACEHOLDER%%
# https://github.com/pypa/get-pip
ENV PYTHON_GET_PIP_URL %%PLACEHOLDER%%
ENV PYTHON_GET_PIP_SHA256 %%PLACEHOLDER%%z


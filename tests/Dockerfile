FROM alpine:3.14.2
RUN apk add --no-cache python3=3.9.5-r2 py3-pip=20.3.4-r1 curl=7.79.1-r2 jq=1.6-r1 bash=5.1.16-r0
COPY ./requirements.txt /requirements.txt
RUN pip3 install --no-cache-dir --requirement ./requirements.txt

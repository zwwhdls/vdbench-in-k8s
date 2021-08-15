FROM ubuntu:18.04

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get update &&\
    apt-get install -y software-properties-common apt-utils &&\
    add-apt-repository ppa:git-core/ppa &&\
    apt-get update &&\
    apt-get install -y git make wget vim && \
    apt-get install -y openjdk-8-jdk && \
	update-alternatives --config java && \
	apt-get install unzip gcc libaio-dev -y

WORKDIR /vdbench

RUN cd /vdbench
COPY /bin/vdbench50406 .

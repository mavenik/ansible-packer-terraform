FROM ubuntu:bionic-20200219

ARG TERRAFORM_VERSION="0.12.23"
ARG PACKER_VERSION="1.5.4"

LABEL maintainer="Codebarber <ernest@codebarber.com>"
LABEL terraform_version=${TERRAFORM_VERSION}
LABEL packer_version=${PACKER_VERSION}
LABEL ansible_version="2.5.1"
LABEL aws_cli_version="2"

ENV DEBIAN_FRONTEND=noninteractive
ENV TERRAFORM_VERSION=${TERRAFORM_VERSION}
ENV PACKER_VERSION=${PACKER_VERSION}
RUN apt-get update \
    && apt-get install -y ansible curl python3 python3-pip python3-boto unzip  \
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf ./aws* \
    && curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
    && curl -LO https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
    && unzip '*.zip' -d /usr/local/bin \
    && rm *.zip

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD    ["/bin/bash"]

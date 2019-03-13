FROM centos:latest
MAINTAINER fmount <fpantano@redhat.com>
LABEL version="1.0"

# Packaged dependencies
RUN yum update -y && \
yum install git curl which -y && \
yum install bundle rubygem-bundler ruby-devel zlib-devel -y && \
yum groupinstall "Development Tools" -y

RUN gpg2 --keyserver hkp://pool.sks-keyservers.net \
    --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
    curl -sSL https://get.rvm.io | bash -s stable

RUN /bin/bash -l -c ". /etc/profile.d/rvm.sh && \
    rvm install 2.3.0 && \
    rvm alias create defaul 2.3.0 && \
    rvm use default && \
    gem install bundler"

ENTRYPOINT ["/bin/bash", "-l", "-c"]

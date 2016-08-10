FROM ruby:2.3.1-slim

# install dependencies
RUN apt-get update -qq && apt-get install --fix-missing -y build-essential locales nodejs

# setup locale
run echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && dpkg-reconfigure --frontend=noninteractive locales
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# build gb
ENV GB /gb
RUN mkdir $GB
COPY . $GB
WORKDIR $GB

RUN ./bin/bundle install --jobs 10 --without development test

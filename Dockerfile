FROM ruby:2.3.1-slim

# install dependencies
RUN apt-get update -qq && apt-get install --fix-missing -y build-essential locales nodejs
RUN locale-gen en_US.UTF-8

# build gb
ENV GB /gb
RUN mkdir $GB
COPY . $GB
WORKDIR $GB

RUN ./bin/bundle install --jobs 10 --without development test

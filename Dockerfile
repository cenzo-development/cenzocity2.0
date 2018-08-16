FROM ruby:2.4.1

LABEL maintainer="harry.obaseki@cenzo.nl"


RUN apt-get install -yqq curl

RUN apt-get update -yqq

RUN apt-get install -yqq apt-transport-https

RUN curl -sL https://deb.nodesource.com/setup_8.x |  bash - &&  apt-get install -yqq nodejs

COPY Gemfile* /usr/src/cenzo-city/

WORKDIR /usr/src/cenzo-city

RUN gem update bundler

RUN bundle install

COPY . /usr/src/cenzo-city


CMD ["rails", "s", "-b", "0.0.0.0"]

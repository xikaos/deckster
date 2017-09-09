FROM ruby:2.4.1-alpine

RUN apk add --no-cache tini
RUN apk add tini ruby libxml2 libxml2-dev libxml2-utils ruby-nokogiri

RUN apk add --no-cache tini
# Tini is now available at /sbin/tini
ENTRYPOINT ["/sbin/tini", "--"]

RUN mkdir /usr/app
WORKDIR /usr/app

COPY Gemfile /usr/app/
COPY Gemfile.lock /usr/app/
RUN bundle install

COPY . /usr/app

FROM ruby:2.7.0-alpine3.11
RUN apk add --update build-base
WORKDIR /jekyll-app
COPY Gemfile ./
RUN bundle install --jobs 16 --retry 8 --verbose
COPY . .

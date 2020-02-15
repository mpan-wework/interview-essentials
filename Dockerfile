FROM ruby:2.5.3-alpine
RUN apk add --update build-base
WORKDIR /jekyll-app
COPY Gemfile ./
RUN bundle install --jobs 16 --retry 8 --verbose
COPY . .

FROM ruby:2.6.3
MAINTAINER Quero ser dev <contato@campuscode.com.br>

ENV BUNDLER_VERSION 2.1.2
ENV NODE_VERSION 12
RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -qq
RUN apt-get install -y --no-install-recommends vim nodejs postgresql-client \
      locales yarn

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
RUN export LC_ALL="en_US.utf8"

RUN mkdir -p /qsd_sales

WORKDIR /qsd_sales
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler:2.1.2
RUN bundle install
RUN gem install bundler-audit

COPY . /qsd_sales

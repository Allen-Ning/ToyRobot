FROM ruby:2.6.6

ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base
ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler

RUN apt-get update -qq && \
		apt-get install -y build-essential \
        netcat \
		git \
		libcurl4-openssl-dev \
		nodejs \
		default-libmysqlclient-dev \
		graphicsmagick \
		wkhtmltopdf \
		&& rm -rf /var/lib/apt/lists/* 

WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN bundle install

COPY . /app

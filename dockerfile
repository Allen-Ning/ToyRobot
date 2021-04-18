FROM ruby:2.6.6

RUN apt-get update -qq && \
	apt-get install -y build-essential \
	libcurl4-openssl-dev \
	&& rm -rf /var/lib/apt/lists/* 

WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN bundle install

COPY . /app

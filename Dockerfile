FROM ruby:2.3

RUN touch /etc/app-env

RUN sed -i '/jessie-updates/d' /etc/apt/sources.list

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 5072E1F5 && \
    echo "deb http://repo.mysql.com/apt/debian/ jessie mysql-5.7" > /etc/apt/sources.list.d/mysql.list && \
    apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs libmysqlclient-dev mysql-client

WORKDIR /app

COPY Gemfile /app
COPY Rakefile /app
COPY bin /app/bin
COPY config.ru /app
COPY janky.gemspec /app
COPY lib /app/lib
COPY script /app/script
COPY test /app/test

RUN bundle install --binstubs
RUN mkdir /app/log

EXPOSE 9393

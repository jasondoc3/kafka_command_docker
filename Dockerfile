FROM ruby:2.6.0
MAINTAINER Jason Dougherty <jasondoc3@gmail.com>

RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get install -y nodejs

RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install --without development test
COPY . .

ENV RAILS_ENV production
ENV CLUSTER_NAME Production
ENV SEED_BROKERS localhost:9092
RUN bundle exec rake assets:precompile

ENV PORT 8080
EXPOSE 8080
CMD puma -C config/puma.rb

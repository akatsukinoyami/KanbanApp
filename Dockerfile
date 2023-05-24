FROM ruby:3.2.2-alpine3.18

RUN apk update && apk add --no-cache build-base libpq-dev

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle

COPY . .

CMD bundle exec rails s -p 3000 -b '0.0.0.0'

EXPOSE 3000
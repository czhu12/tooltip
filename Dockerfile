FROM ruby:3.0.1-alpine

ENV APP_PATH /var/app
ENV BUNDLE_VERSION 2.2.15
ENV BUNDLE_PATH /usr/local/bundle/gems
ENV TMP_PATH /tmp/
ENV RAILS_LOG_TO_STDOUT true
ENV PORT 3000

# install dependencies for application
RUN apk -U add --no-cache \
  build-base \
  git \
  postgresql-dev \
  postgresql-client \
  libxml2-dev \
  libxslt-dev \
  nodejs \
  yarn \
  tzdata \
  && rm -rf /var/cache/apk/* \
  && mkdir -p $APP_PATH 

# navigate to app directory
COPY ./Gemfile $APP_PATH
COPY ./Gemfile.lock $APP_PATH

WORKDIR $APP_PATH
RUN gem install bundler --version "$BUNDLE_VERSION" && rm -rf $GEM_HOME/cache/*
RUN bundle install

COPY ./ $APP_PATH

RUN RAILS_ENV=production SECRET_KEY_BASE=`bin/rake secret` bundle exec rake assets:precompile
CMD bundle exec rails db:migrate && bundle exec rails s -b 0.0.0.0 -p $PORT -e production

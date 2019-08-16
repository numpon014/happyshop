FROM ruby:2.3.7

ENV RAILS_ENV=production
ENV RACK_ENV=production

RUN mkdir /onyxserver
WORKDIR /onyxserver

COPY Gemfile /onyxserver/Gemfile
RUN bundle install
COPY . /onyxserver

EXPOSE 3000

# Start the main process.
RUN chmod +x docker/startup.sh
CMD ["docker/startup.sh"]
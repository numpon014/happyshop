FROM ruby:2.3.7

ENV RAILS_ENV=production
ENV RACK_ENV=production

RUN mkdir /happyshop
WORKDIR /onyxserver

COPY Gemfile /happyshop/Gemfile
RUN bundle install
COPY . /happyshop

EXPOSE 3000

# Start the main process.
RUN chmod +x docker/startup.sh
CMD ["docker/startup.sh"]
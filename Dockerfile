# syntax=docker/dockerfile:1
FROM ruby:3.2.2

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt bookworm-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Install packages.
RUN apt update -qq
RUN apt install -y postgresql-client-15

WORKDIR /api_data
COPY Gemfile /api_data/Gemfile
COPY Gemfile.lock /api_data/Gemfile.lock
COPY Gemfile .
COPY Gemfile.lock .
RUN bundle install
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
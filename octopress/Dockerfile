FROM ubuntu:14.04
MAINTAINER  Nate Jones <nate@endot.org>

# instal system dependencies and ruby
RUN apt-get update
RUN apt-get install git ruby1.9.3 build-essential language-pack-en python python-dev -y

# make sure we're working in UTF8
ENV LC_ALL en_US.utf8

# add the current blog source
ADD . /o
WORKDIR /o

# install octopress dependencies
RUN gem install bundler
RUN bundle install

# set up user so that host files have correct ownership
RUN addgroup --gid 1000 blog
RUN adduser --uid 1000 --gid 1000 blog
RUN chown -R blog.blog /o
USER blog

# base command
ENTRYPOINT ["rake"]

#example: docker run --rm -v `pwd`:/o octodock generate

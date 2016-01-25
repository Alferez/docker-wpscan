FROM debian:8

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y libreadline6 libreadline6-dev subversion git ruby build-essential libpq-dev bundler curl

RUN mkdir /scripts
WORKDIR /scripts
RUN git clone git://github.com/wpscanteam/wpscan.git

WORKDIR /scripts/wpscan
RUN bundle install
RUN chmod +x /scripts/wpscan/*.rb
RUN ./wpscan.rb --update
RUN echo "#! /bin/bash" >> /scripts/wpscan.sh
RUN echo "/scripts/wpscan/wpscan.rb --update >/dev/null" >> /scripts/wpscan.sh
RUN echo "/scripts/wpscan/wpscan.rb -u \$1" >> /scripts/wpscan.sh
RUN chmod 777 /scripts/wpscan.sh

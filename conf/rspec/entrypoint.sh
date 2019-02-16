#!/bin/sh

cd $(dirname $0)
gem install rspec
gem install faraday
rspec

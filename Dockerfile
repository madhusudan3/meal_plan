FROM ruby:2.5.1

RUN apt-get update -yqq \
	&& apt-get install -yqq --no-install-recommends \
		postgresql-client \
		nodejs \
	&& apt-get -q clean \
	&& rm -rf /var/lib/apt/lists

RUN gem install nokogiri -v "1.8.2"

WORKDIR /usr/scr/app
COPY Gemfile* ./
RUN bundle install
COPY . .

CMD rails server -b 0.0.0.0 -P /tmp/puma.pid
FROM 'ruby:2.5'

COPY start.sh /

ARG version=master

ENV VERSION=$version

RUN apt-get install git && \
            git clone -b $VERSION https://github.com/voxpupuli/puppet_webhook.git app/ && \
            cd /app && \
            bundle install

ENV SINATRA_ENV production

EXPOSE 9292

ENTRYPOINT '/start.sh'

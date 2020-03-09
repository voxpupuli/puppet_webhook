FROM 'ruby:2.5' as rubybuilder
ARG version=master

# Replace with a pull from releases page
RUN gem install bundler:2.1.4

RUN apt-get install git && \
            git clone -b $version https://github.com/voxpupuli/puppet_webhook.git app/ && \
            cd /app && \
            bundle install --without development

RUN mkdir /root/.ssh && echo "StrictHostKeyChecking no" >> /root/.ssh/config

EXPOSE 9292
COPY start.sh /

ENTRYPOINT '/start.sh'

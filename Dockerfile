FROM consul:0.8.1

ARG SERVICE_NAME="."

RUN apk update && apk upgrade && apk --update add \
    ruby ruby-rake ruby-io-console ruby-bigdecimal ruby-json ruby-bundler \
    libstdc++ tzdata bash ca-certificates \
    &&  echo 'gem: --no-document' > /etc/gemrc

RUN gem install rdoc

RUN gem update --system && gem install bundler

COPY ./${SERVICE_NAME}  /config/${SERVICE_NAME}

RUN cd /config && bundle install

ENTRYPOINT ["ruby", "/config/consul_push.rb"]

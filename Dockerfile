FROM ubuntu:14.04
MAINTAINER Sett <sett@rigmarolesoup.com>

RUN apt-get install -yq curl python3 python3-setuptools

ENV OWNCLOUD_NEWS_VERSION 6.0.4

RUN cd /tmp && curl -L -o owncloud-news.tar.gz "https://github.com/owncloud/news/archive/${OWNCLOUD_NEWS_VERSION}.tar.gz" \
  && tar -xvf /tmp/owncloud-news.tar.gz -C /opt

RUN cd /opt/news-${OWNCLOUD_NEWS_VERSION}/bin/updater && \
  python3 setup.py install

ENV OWNCLOUD_USER ouser
ENV OWNCLOUD_PASSWORD opassword
ENV OWNCLOUD_URL http://my.own.private.owncloud.com

COPY docker-entrypoint.sh /entrypoint.sh

CMD owncloud-news-updater -u $OWNCLOUD_USER -p $OWNCLOUD_PASSWORD $OWNCLOUD_URL

FROM sentry:onbuild

MAINTAINER blacktop, https://github.com/blacktop

COPY requirements.txt /requirements.txt
COPY sentry.conf.py /sentry.conf.py
COPY config.yml /config.yml

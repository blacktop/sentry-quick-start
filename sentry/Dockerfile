FROM sentry

MAINTAINER blacktop, https://github.com/blacktop

# ENV http_proxy PROXY
# ENV https_proxy PROXY
# ENV no_proxy NO_PROXY

RUN apt-get update \
  && apt-get install -yq ca-certificates netcat --no-install-recommends \
  && pip install -U sentry-plugins sentry-auth-gitlab

COPY sentry.conf.py /etc/sentry/
COPY config.yml /etc/sentry/
COPY docker-entrypoint.sh /entrypoint.sh

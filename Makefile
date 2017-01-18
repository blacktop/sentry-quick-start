SECRET_KEY=$(shell docker run --rm sentry config generate-secret-key)
SENTRY_URL=localhost

certs:
	test -f nginx/certs/sentry.key || openssl req -x509 -nodes -days 3650 -newkey rsa:4096 -keyout nginx/certs/sentry.key -out nginx/certs/sentry.crt -subj '/CN=$(SENTRY_URL)'

db:
	docker-compose up -d redis
	docker-compose up -d postgres

upgrade: db
	docker-compose build sentry
	SENTRY_SECRET_KEY='$(SECRET_KEY)' docker-compose run --rm sentry upgrade

sentry: certs upgrade
	SENTRY_SECRET_KEY='$(SECRET_KEY)' NGINX_HOST='$(SENTRY_URL)' docker-compose up -d

clean:
	@[ -f nginx/certs/sentry.key ] && rm nginx/certs/sentry.* || true

.PHONY: sentry certs upgrade db

sentry-quick-start
==================

[Sentry](https://docs.sentry.io) Docker Quick Start

Getting Started
---------------

> **NOTE:** update configuration in `.env` file

```bash
$ SENTRY_URL=sentry.blacktop.io make sentry
```

> **NOTE:** Change the `SENTRY_URL` to your sentry's url-prefix

Fill out the **superuser** information

```bash
Would you like to create a user account now? [Y/n]:
Email: blacktop@yahoo.com
Password: ***********
Repeat for confirmation: ***********
Should this user be a superuser? [y/N]: y
```

### Add more workers

```bash
$ SENTRY_SECRET_KEY=secret docker-compose scale worker=3
```

### Added Auth Plugins

-	https://github.com/SkyLothar/sentry-auth-gitlab

### License

MIT Copyright (c) 2016-2017 blacktop

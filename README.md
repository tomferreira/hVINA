hVINA
=====

Hierarchical Viewer of news articles

## Compile

```
RAILS_ENV=production rails generate delayed_job:upgrade
RAILS_ENV=production rake db:migrate
RAILS_ENV=production rake assets:precompile
```

## Run

```
SECRET_KEY_BASE=<your secret hash> rails s -e production
```

## Restarting Delayed Job

```
RAILS_ENV=production bin/delayed_job restart
```
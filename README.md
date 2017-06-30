
### README

### 1. Prepare for running (server or testing)

database init

```
bin/rails db:migrate RAILS_ENV=development
bin/rails db:seed RAILS_ENV=development

bin/rails db:migrate RAILS_ENV=test
```

start redis server  

```
redis-server
```

### 2. How to run server

```
bundle exec sidekiq --config ./config/sidekiq.yml RAILS_ENV='development'
```

```
bin/rails server -b '127.0.0.1' -p 9090 RAILS_ENV='development'
```

open [http://127.0.0.1:9090](http://127.0.0.1:9090) in your brower

### 3. How to run testing

```
bundle exec rspec
```

# sales-on

[![Build Status](https://travis-ci.org/CreceLibre/sales-on.svg?branch=master)](https://travis-ci.org/CreceLibre/sales-on.svg?branch=master)

Simple micro-service oriented sales app

## Install steps

1.- Just run the usual bundle dance

```bash
bundle
```

2.- Create database.yml

```bash
cp config/database.yml.copyme config/database.yml
```

3.- Populate some test data for sqlite (development environment)

```bash
RACK_ENV=development bundle exec rake db:seed
```

4.- Now run it!

```bash
bundle exec rackup
```

Here is a simple API call using `curl`:

```bash
curl http://localhost:9292/api/v1/products/1
```

The API should respond with:

```json
{"product":{"id":1,"name":"heineken","category":"beer"}}
```

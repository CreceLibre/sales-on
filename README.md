# sales-on

[![Build Status](https://travis-ci.org/CreceLibre/sales-on.svg?branch=master)](https://travis-ci.org/CreceLibre/sales-on)

Simple SPA sales app

## Dependencies

Make sure you have the following installed

* elm 0.17
* redis
* npm
* ruby 2.2.3
* bundler

## 1 - Install pkgs for development

First let's download all needed library to run the app.

```bash
bundle
```

```bash
npm install
```

```bash
elm make
```

## 2 - Create test data base

Next step is to have a valid database config for our test data (TODO: this should be done by a ruby script).

```bash
cp config/database.yml.copyme config/database.yml
```

## 3 - Populate some test data for sqlite (development environment)


We will need to add some data, for this, we will take advantage from the current frabricated objects used in testing.
```bash
RACK_ENV=development bundle exec rake db:seed
```

## 4 - Now run it!

```bash
npm run api
```

```bash
npm run watch
```

*Caveat*: `npm run watch` only watches for frontend code changes

## 5 - App test

Point your browser to [http://localhost:9292](http://localhost:9292) and you should see the app with some test data.

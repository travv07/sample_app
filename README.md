# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
    ruby '2.5.5'
* System dependencies

* Configuration

* Database creation
    gem 'mysql2', '>= 0.4.4', '< 0.6.0'
* Database initialization
    rake db:create
* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

## Getting started

To get started with the app, clone the repo and then install the needed gems:

```
$ bundle install

Next, migrate the database:

```
$ rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:

```
$ rails test
```

If the test suite passes, you'll be ready to run the app in a local server:

```
$ rails server
```

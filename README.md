# Friends Pop [![Build Status](https://travis-ci.org/kumonos/whoswhoplus.svg?branch=master)](https://travis-ci.org/kumonos/whoswhoplus)

[kumonos](http://kumonos.jp/)

## 開発環境

### 環境構築

以下は例です。

```bash
$ brew install redis
$ git clone https://github.com/kumonos/whoswhoplus.git
$ cd whoswhoplus
$ bundle install --path vendor/bundle --without staging production
$ cp ./config/initializers/constants{.example,}.rb
$ vim ./config/initializers/constants.rb
  -> Setup Facebook Token etc.
$ bundle exec rake db:seed
```

### 起動

```
$ redis-server
$ bundle exec rails server
```

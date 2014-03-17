### とりあえずやること

* apiで取ってきたJSONデータのパース->youcune
* FB apiから取得するデータ修正->tomoima
* 
### gitignoreしてるもの
* gitignoreして大丈夫なんすかねこれら…
/.bundle
/db/*.sqlite3
/db/*.sqlite3-journal
/log/*.log
/tmp
config/initializers/constants.rb

### 03/04 youcune

* Gemfile 更新しました。 `bundle install` お願いします。
* DB設計考えました。レビューおねがいします。 ./db/migrate/ 以下にあります。
  * users テーブルは、毎回認証やAPI通信をする必要がないように access_token とか必要そうなデータをおいておくところ
  * friends テーブルはFacebookの友だち関係をキャッシュしておくところ
* JSONのparse → 最初からHashになってました。HashをJSON.parseしようとしているからエラーだったと思います

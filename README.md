# アプリケーション名  
傘いる？bot in 東京  
![weather_line_bot_qr](https://user-images.githubusercontent.com/48372923/56089239-ef238d00-5eca-11e9-87bc-eb7a35188193.png)  
  
# 概要  
東京の降水確率をお知らせ・閲覧できるLINE botです。
  
# 機能一覧  
東京の当日の降水確率が50％以上の場合、朝7時に通知 => rakeタスク, Heroku Scheduler  
東京の当日、翌日、翌々日の降水確率の閲覧 => webhook  

# 使用している技術一覧  
言語 => Ruby  
フレームワーク => Ruby on Rails  
データベース => PostgreSQL  
バージョン管理 => Git  
リポジトリ管理 => GitHub  
インフラ => Heroku  
API => LINE Messaging API  
ライブラリ => line/bot, open-uri, kconv, rexml/document  
天気予報情報（XML） => <https://www.drk7.jp/weather/>  
  
# 使用方法  
上記のQRコードを読み取って、「傘いる？bot in 東京」を友だち追加してください。  
今日、明日、明後日のいずれかを入力すると、  
  
 今日 => 今日の降水確率  
 明日 => 明日の降水確率  
 明後日 => 明後日の降水確率  
  
を確認できます。  
また、東京の当日の降水確率が50％以上の場合、朝7時に通知が届きます。

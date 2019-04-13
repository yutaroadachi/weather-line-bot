desc '当日の東京エリアの降水確率（6~12時、12~18時、18~24時）のいずれか1つが50%以上であった場合にメッセージを送信'
task :rain_notification => :environment do
  require 'line/bot'
  require 'open-uri'
  require 'kconv'
  require 'rexml/document'

  client ||= Line::Bot::Client.new { |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token  = ENV["LINE_CHANNEL_TOKEN"]
  }

  url = 'https://www.drk7.jp/weather/xml/13.xml'
  # XMLデータをパース
  xml = open(url).read.toutf8
  doc = REXML::Document.new(xml)
  # パスの共通部分を変数化（area[4]は「東京地方」を指定）
  xpath = 'weatherforecast/pref/area[4]/info/rainfallchance/'
  # 各時間帯の降水確率
  per06to12 = doc.elements[xpath + 'period[2]'].text
  per12to18 = doc.elements[xpath + 'period[3]'].text
  per18to24 = doc.elements[xpath + 'period[4]'].text
  # メッセージを送信する降水確率の下限値の設定
  min_per = 50
  if per06to12.to_i >= min_per || per12to18.to_i >= min_per || per18to24.to_i >= min_per
    # 送信するメッセージの設定
    content = "おはようございます。\n今日は雨が降りそうなので、傘があると安心です。\n\n【降水確率】\n  6〜12時 #{per06to12}％\n 12〜18時 #{per12to18}％\n 18〜24時 #{per18to24}％"
    # メッセージの送信先の設定
    user_ids = User.all.pluck(:line_id)
    message = {
      type: 'text',
      text: content
    }
    response = client.multicast(user_ids, message)
  end
  "OK"
end

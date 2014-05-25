# マスタデータ投入
Template.delete_all
Template.create(
  objective: '3人で飲みに行きたい',
  body: 'あなたの友達の$$TARGET$$さんに興味があります。近いうちに3人で飲みに行きませんか？'
)
Template.create(
  objective: 'どんな人か知りたい',
  body: 'あなたの友達の$$TARGET$$さんに興味があります。$$TARGET$$さんってどんな人なんですか？'
)
Template.create(
  objective: '連絡先を教えてほしい',
  body: 'あなたの友達の$$TARGET$$さんに興味があります。連絡先を教えてくれませんか？'
)
Template.create(
  objective: 'お茶したい',
  body: 'あなたの友達の$$TARGET$$さんに興味があります。お茶でもどうですかと連絡してくれませんか？'
)
Template.create(
  objective: 'その他（自分で書く）',
  body: ''
)

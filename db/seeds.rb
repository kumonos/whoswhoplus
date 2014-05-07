# マスタデータ投入
Template.delete_all
Template.create(
  objective: '3人で飲みたい',
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

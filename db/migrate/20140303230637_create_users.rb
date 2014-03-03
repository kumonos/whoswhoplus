class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :facebook_id   # JSONがstring形式なので合わせておく
      t.string :access_token
      t.string :name
      t.date :birthday        # 年齢を計算できるように
      t.string :gender        # 'male' / 'female'
      t.string :picture_url

      t.timestamps
    end
  end
end

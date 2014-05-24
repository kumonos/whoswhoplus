require 'spec_helper'

describe Facebook::Photo do
  subject{
    Facebook::Photo.new(
      "id" => "11111111111111111",
      "from" => {
        "id" => "1111111111",
        "name" => "Mary Spring"
      },
      "name" => "こんにちは",
      "picture" => "https://fbcdn-photos-e-a.akamaihd.net/xxxxxxx-xx-xxxx/t1.0-0/1111111_11111111111111111_1111111111_s.jpg",
      "source" => "https://scontent-a.xx.fbcdn.net/xxxxxxx-xxxx/t1.0-9/s720x720/1111111_11111111111111111_1111111111_n.jpg",
      "height" => 480,
      "width" => 720,
      "link" => "https://www.facebook.com/photo.php?fbid=11111111111111111&set=p.11111111111111111&type=1",
      "icon" => "https://fbstatic-a.akamaihd.net/rsrc.php/v2/xx/x/xxxxxxxxxxx.gif",
      "created_time" => "2014-03-26T12:48:14+0000",
      "updated_time" => "2014-03-28T03:25:45+0000",
      "tags" => {
        "data" => [
          {
            "id" => "111111111111111",
            "name" => "Kony Summer",
            "created_time" => "2014-03-26T12:48:15+0000",
            "x" => 46.593032836914,
            "y" => 30.868648529053
          },
          {
            "id" => "222222222222222",
            "name" => "Tommy Autumn",
            "created_time" => "2014-03-26T12:48:15+0000",
            "x" => 69.258918762207,
            "y" => 55.23258972168
          }
        ]
      }
    )
  }

  describe '#new' do
    it 'インスタンスを作成できる' do
      expect{ subject }.not_to raise_error
    end
  end

  describe '#thumbnail_url' do
    it 'サムネイル URL を返す' do
      expect(subject.thumbnail_url).to eq 'https://fbcdn-photos-e-a.akamaihd.net/xxxxxxx-xx-xxxx/t1.0-0/1111111_11111111111111111_1111111111_s.jpg'
    end
  end

  describe '#photo_url' do
    it '拡大写真の URL を返す' do
      expect(subject.photo_url).to eq 'https://scontent-a.xx.fbcdn.net/xxxxxxx-xxxx/t1.0-9/s720x720/1111111_11111111111111111_1111111111_n.jpg'
    end
  end

  describe '#find' do
    it '指定したユーザが見つかった場合 x, y をそのまま返す' do
      expect(subject.find('111111111111111')).to eq [46.593032836914, 30.868648529053]
    end

    it '指定したユーザが見つからなかった場合 nil を返す' do
      expect(subject.find('333333333333333')).to be_nil
    end
  end

  describe '#tagged?' do
    it '指定したユーザが見つかった場合 x, y をそのまま返す' do
      expect(subject.tagged?('111111111111111')).to be true
    end

    it '指定したユーザが見つからなかった場合 nil を返す' do
      expect(subject.tagged?('333333333333333')).to be false
    end
  end
end

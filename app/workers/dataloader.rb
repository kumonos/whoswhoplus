class Dataloader
	@queue = :data_loader

	def self.perform(fb_id)
	  @profile=Profile.getUser(fb_id)
    #更新時間が1分以内(ログイン直後)または1時間以上経過している場合データを更新する          
      if @profile.updated_at  >= 1.minute.ago ||  @profile.updated_at <= 1.hour.ago
      	start_time = Time.now
        #ユーザーの友人情報をprofilesに格納
        @friends=@profile.api.get_object('/me/friends','fields'=>'name,gender,picture.width(200).height(200),relationship_status,birthday','locale' =>'ja_JP')
        Profile.insert(@friends)
        #「ユーザーの友人」と「友人」のfb_idをrelationsに登録する
        Relation.insert(fb_id,@friends)
        @profile.touch
        end_time = Time.now
        time_taken = end_time - start_time
        path = File.expand_path("log/users.log", Rails.root)
        File.open(path, 'a') do |f|
          f.puts "Load data #{fb_id} time: #{time_taken} counts: #{@friends.size}"
        end
      end
    end
end
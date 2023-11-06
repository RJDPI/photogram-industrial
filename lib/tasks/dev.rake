desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do

  p "Creating sample data"

  if Rails.env.development?
    FollowRequest.destroy_all
    Comment.destroy_all
    Like.destroy_all
    Photo.destroy_all
    User.destroy_all
  end
# new_user= User.create(email: "cody@example.com",
# password: "password",
# username: "cody",
# private: [true, false].sample,)

usernames = Array.new { Faker::Name.first_name }

usernames << "alice"
usernames << "bob"

usernames.each do |username|
  User.create(
    email: "#{username}@example.com",
    password: "password",
    username: username.downcase,
    private: [true, false].sample,
  )
end

  12.times do
    name = Faker::Name.first_name
    user = User.create(
      email: "#{name}@example.com",
      password: "password",
      username: name,
      private: [true, false].sample,
    )
    user.save
  end

  p "There are now #{User.count} users."

  users = User.all
  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.keys.sample
        )
      end

      if rand < 0.75
        second_user.sent_follow_requests.create(
          recipient: first_user,
          status: FollowRequest.statuses.keys.sample
        )
      end
    end
  end

  p "There are now #{FollowRequest.count} follow requests."


  users.each do |user|
    rand(3).times do
      url = URI("https://api.thecatapi.com/v1/images/search")
      raw_data = Net::HTTP.get(url)
      parsed_data = JSON.parse(raw_data)
      photo = user.own_photos.create(
        caption: Faker::Quote.jack_handey,
        image: @pic_url = parsed_data[0].fetch("url").to_s 
      )

      user.followers.each do |follower|
        if rand < 0.5
          photo.fans << follower
        end

        if rand < 0.25
          photo.comments.create(
            body: Faker::Quote.jack_handey,
            author: follower
          )
        end
      end
    end
  end

  p "There are now #{Photo.count} photos."
  p "There are now #{Like.count} likes."
  p "There are now #{Comment.count} comments."

end

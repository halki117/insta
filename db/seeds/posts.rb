puts 'Start inserting seed "posts" ...'
User.limit(10).each do |user|
  post = user.posts.create(description: Faker::Movies::HarryPotter.quote, remote_images_urls: %w[https://picsum.photos/350/350/?random https://picsum.photos/350/350/?random])
  puts "post#{post.id} has created!"
end
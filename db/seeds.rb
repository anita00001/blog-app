require "faker"

10.times do |i|
  User.create(
    name: Faker::Name.name,
    photo: "https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png",
    bio: Faker::Lorem.paragraphs(number: 1).join("\n\n"),
    post_counter: 0
  )
end

40.times do
  Post.create(
    author_id: rand(1..11),
    title: Faker::Lorem.sentence,
    text: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
    likes_counter: rand(0..50),
    comments_counter: rand(0..20)
  )
end

250.times do
  Comment.create(
    user_id: rand(1..11),
    post_id: rand(1..50),
    text: Faker::Lorem.paragraphs(number: 1).join("\n\n")
  )
end

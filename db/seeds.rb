# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
PostCategory.destroy_all

User.create!(
  [
    { email: 'admin@email.com',
      password: 'adminsecret',
      password_confirmation: 'adminsecret' },
    { email: 'user@email.com',
      password: 'usersecret',
      password_confirmation: 'usersecret' }
  ]
)

PostCategory.create!([{ name: 'sport' }, { name: 'science' }])

Post.create!(
  [
    { creator: User.first,
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph_by_chars(number: 400),
      post_category: PostCategory.first },
    { creator: User.second,
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph_by_chars(number: 300),
      post_category: PostCategory.second }
  ]
)

PostLike.create!(user: User.first, post: Post.first)

PostComment.create!(user: User.first, post: Post.second, content: Faker::Lorem.paragraph_by_chars(number: 50))

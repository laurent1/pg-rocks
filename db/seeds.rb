# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

Post.create!(:title => 'Postgres is awesome')
Post.create!(:title => 'Oracle acquires some other database')
Post.create!(:title => 'How Postgres is different from MySQL')
Post.create!(:title => 'Tips for MySQL refugees')
Post.create!(:title => 'TOP SECRET', :body => 'Postgres rocks')

if Comment.count == 0
  posts = Post.all
  Comment.create!(:post => posts.first)
  Comment.create!(:post => posts.second)
  Comment.create!(:post => posts.second)
end
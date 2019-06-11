class Post < ApplicationRecord
# performs a "cascade delete", which ensures that when a post is deleted, all of its comments are too.
    has_many :comments, dependent: :destroy
end

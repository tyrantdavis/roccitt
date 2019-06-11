class Post < ApplicationRecord
    belongs_to :topic
    # performs a "cascade delete", which ensures that when a post is deleted, all of its comments are too.
    has_many :comments, dependent: :destroy
end

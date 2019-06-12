class Post < ApplicationRecord
    belongs_to :topic
    # performs a "cascade delete", which ensures that when a post is deleted, all of its comments are too.
    has_many :comments, dependent: :destroy

   validates :title, length: { minimum: 5 }, presence: true
   validates :body, length: { minimum: 20 }, presence: true
   validates :topic, presence: true
end

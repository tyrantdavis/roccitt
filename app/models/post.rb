class Post < ApplicationRecord
    belongs_to :topic
    belongs_to :user
    # performs a "cascade delete", which ensures that when a post is deleted, all of its comments are too.
    has_many :comments, dependent: :destroy
   default_scope { order('created_at DESC') }

   validates :title, length: { minimum: 5 }, presence: true
   validates :body, length: { minimum: 20 }, presence: true
   validates :topic, presence: true
   validates :user, presence: true
   
end

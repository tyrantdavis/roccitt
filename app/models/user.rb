class User < ApplicationRecord
   has_many :posts, dependent: :destroy
   has_many :comments, dependent: :destroy
   has_many :votes, dependent: :destroy
   has_many :favorites, dependent: :destroy
   before_save :format_email
   before_save :format_name
   before_save :role?

   VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

   validates :name, length: { minimum: 1, maximum: 100 }, presence: true

   validates :password, presence: true, length: { minimum: 6 }, 
   if: Proc.new { |a| a.password_digest.nil?  }
   validates :password, length: { minimum: 6 }, allow_blank: true

   validates :email,
            presence: true,
            uniqueness: { case_sensitive: false},
            length: { minimum: 3, maximum: 254 },
            format: { with: VALID_EMAIL_REGEX  }

   has_secure_password
   enum role: [:member, :admin]
   
   private
   def format_name
      self.name = name.split.each {|n| n.capitalize!}.join(" ") if name
   end

   def format_email
      self.email = email.downcase if email.present?
   end
   
   def role?
      self.role ||= :member
   end
   
   def favorite_for(post)
     favorites.where(post_id: post.id).first
   end   
end

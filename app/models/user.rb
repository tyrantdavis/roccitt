class User < ApplicationRecord
   has_secure_password
   has_many :posts
   before_save :format_email
   before_save :format_name

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

   private
   def format_name
      self.name = name.split.each {|n| n.capitalize!}.join(" ") if name
   end

   def format_email
      self.email = email.downcase if email.present?
   end
   
end

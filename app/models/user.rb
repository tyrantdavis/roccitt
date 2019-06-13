class User < ApplicationRecord
   has_secure_password

   before_save { self.email = email.downcase if email.present? }

   validates :name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password, presence: true, length: { minimum: 6 }, 
  if: Proc.new { |a| a.password_digest.nil?  }
  validates :password, length: { minimum: 6 }, allow_blank: true

   validates :email,
             presence: true,
             uniqueness: { case_sensitive: false},
             length: { minimum: 3, maximum: 254 }

end

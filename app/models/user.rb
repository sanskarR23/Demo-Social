class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         validates :otp_secret, presence: true
  has_many :posts
  has_many :likes
  has_and_belongs_to_many :liked_posts, class_name: "Post", source: :post


  def generate_otp
    self.otp_secret = ROTP::Base32.random_base32
    save
  end

  def otp_valid?(code)
    totp = ROTP::TOTP.new(otp_secret)
    totp.verify(code)
  end
end

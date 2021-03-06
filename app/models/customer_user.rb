class CustomerUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments
  has_many :reviews
  has_many :bookmarks
  has_one_attached :avatar

  validates :name, presence: true

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer_user|
      customer_user.password = SecureRandom.urlsafe_base64
      customer_user.name = 'ゲスト'
    end
  end
end

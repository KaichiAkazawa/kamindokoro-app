class OwnerUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true

  def self.guest
    find_or_create_by!(email: 'guest2@example.com') do |owner_user|
      owner_user.password = SecureRandom.urlsafe_base64
      owner_user.name = "オーナーゲスト"
    end
  end
end

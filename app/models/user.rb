class User < ApplicationRecord
  has_many :orders, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.ransackable_attributes(auth_object = nil)
    %w[address created_at email id remember_created_at reset_password_sent_at updated_at ]
  end

  def self.ransackable_associations(auth_object = nil)
    [] # No associations to search by default
  end
end

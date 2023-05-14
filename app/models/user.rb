class User < ApplicationRecord
  has_many :questions

  validates :user_id, uniqueness: true
  validates :name, presence: true
end

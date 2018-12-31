class Recipe < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true, length: {minimum: 5, maxiumum: 500}
  
  belongs_to :user
  validates :user_id, presence: true
end
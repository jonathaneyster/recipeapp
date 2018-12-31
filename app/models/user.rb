class User < ApplicationRecord
  before_save {self.enail = email.downcase}
  validates :name, presence: true, lengthh: {maximum: 30}
  VALID_EMAIL_REGEX =  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maxiumum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  
end
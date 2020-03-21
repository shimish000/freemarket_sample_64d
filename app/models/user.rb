class User < ApplicationRecord
  devise :database_authenticatable, :regiterable,
         :recoverable, :rememberale, :validatable

has_many :cards

has_many :items
end

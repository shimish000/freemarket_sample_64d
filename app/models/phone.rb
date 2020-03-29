class Phone < ApplicationRecord
  belongs_to :user, optional: true
  validates :phone, presence: true, uniqueness: true
end

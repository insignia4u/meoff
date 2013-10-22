class Company < ActiveRecord::Base
  has_many :users
  has_many :notifications

  validates :name, presence: true, uniqueness: true
end

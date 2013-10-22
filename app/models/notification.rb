class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :company

  validates :user, :company, :scheduled_on, :reason, presence: true
end

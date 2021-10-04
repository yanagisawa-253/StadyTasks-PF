class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task
  has_many :notifications
  
  validates :comment, presence: true
end

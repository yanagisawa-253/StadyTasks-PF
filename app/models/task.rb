class Task < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, {presence: true, length: { maximum: 20 }}
  validates :body, {presence: true, length: { maximum: 50 }}
end

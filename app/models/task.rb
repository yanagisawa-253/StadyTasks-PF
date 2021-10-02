class Task < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def like_by?(user)
    likes.where(user_id: user.id).exists?
  end

  validates :title, {presence: true, length: { maximum: 20 }}
  validates :body, {presence: true, length: { maximum: 50 }}
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_many :tasks, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # すでにいいねをしているのかどうかを判定
  def liked_by?(task_id)
    likes.where(task_id: task_id).exists?
  end

  attachment :profile_image_id
end

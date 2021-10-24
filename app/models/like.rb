class Like < ApplicationRecord
  belongs_to :user
  belongs_to :task
  # １つの投稿に対して１つしかいいねをつけられないよう制限
  validates_uniqueness_of :task_id, scope: :user_id
end

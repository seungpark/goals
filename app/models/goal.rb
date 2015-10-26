class Goal < ActiveRecord::Base
  validates :title, :content, :privacy, :user_id, :completed, presence: true
  belongs_to :user

  has_many(
    :comments,
    class_name: "GoalComment",
    foreign_key: :goal_id,
    primary_key: :id
  )



end

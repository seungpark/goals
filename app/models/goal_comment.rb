class GoalComment < ActiveRecord::Base
  validates :author_id, :body, :goal_id, presence: true
  validate :not_own_goal

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )

  belongs_to :goal

  def not_own_goal
    if goal.user_id == author_id
      errors.add(:author_id, "Can't comment on own goal")
    end
  end
end

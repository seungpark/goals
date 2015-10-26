class UserComment < ActiveRecord::Base
  validates :user_id, :author_id, :body, presence: true
  validate :author_user_not_match

  belongs_to(
    :author,
    foreign_key: :author_id,
    primary_key: :id,
    class_name: "User"
  )

  belongs_to :user

  def author_user_not_match
    if user_id == author_id
      errors.add(:author_id, "can't write comment about self")
    end
  end
end

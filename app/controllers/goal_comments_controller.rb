class GoalCommentsController < ApplicationController

  def create
    @goalcomment = current_user.goal_comments.new(goal_comment_params)
    if @goalcomment.save
      redirect_to goal_url(@goalcomment.goal_id)
    else
      flash[:errors] = @goalcomment.errors.full_messages
      redirect_to goal_url(@goalcomment.goal_id)
    end
  end

  private

  def goal_comment_params
    params.require(:goal_comment).permit(:goal_id, :body)
  end

end

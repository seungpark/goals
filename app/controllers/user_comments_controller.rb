class UserCommentsController < ApplicationController

  def create
    @usercomment = current_user.written_user_comments.new(user_comment_params)
    if @usercomment.save
      redirect_to user_url(@usercomment.user_id)
    else
      flash[:errors] = @usercomment.errors.full_messages
      redirect_to user_url(@usercomment.user_id)
    end
  end

  def user_comment_params
    params.require(:user_comment).permit(:user_id, :body)
  end

end

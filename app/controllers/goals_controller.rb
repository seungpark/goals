class GoalsController < ApplicationController
  before_action :require_current_user

  def new
    @goal = Goal.new
    render :new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def show
    @goal = Goal.find(params[:id])
    if @goal.privacy == "1"
      redirect_unless_user_goal(@goal)
    else
      render :show
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    redirect_unless_user_goal(@goal)
    @goal.destroy
    redirect_to goals_url
  end

  def edit
    @goal = Goal.find(params[:id])
    redirect_unless_user_goal(@goal)
  end

  def index
    @goals = Goal.all
    render :index
  end

  def goal_params
    params.require(:goal).permit(:title, :content, :privacy)
  end

  def redirect_unless_user_goal(goal)
    redirect_to goals_url if current_user != goal.user
  end
end

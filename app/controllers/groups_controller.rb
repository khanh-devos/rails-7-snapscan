class GroupsController < ApplicationController
  def index
    @title = 'CATEGORIES'
    @groups = Group.all.where(user_id: current_user.id)
      .order(created_at: 'desc').includes(:expenses_groups)
  end

  def show
    @title = 'CATEGORY DETAILS'
    @group = Group.find(params[:id])
    @expenses_group = ExpensesGroup.where(group_id: params[:id])
      .order(created_at: 'desc').includes(:expense)
  end

  def new
    @title = 'NEW CATEGORY'
  end

  def create
    new_group = Group.new(group_params)
    new_group.user_id = current_user.id

    if new_group.save
      flash[:notice] = 'Successfully created'
      redirect_to '/home'
    else
      flash[:alert] = 'Failed to create'
      redirect_to request.referer
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end
end

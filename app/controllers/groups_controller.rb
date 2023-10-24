class GroupsController < ApplicationController
  
  def index
    @groups = Group.all.order(created_at: 'desc')
  end

  def show
    @expenses_group = ExpensesGroup.where(group_id: params[:id])
  end

  def new
  end


  def create
    new_group = Group.new(group_params)
    new_group.user_id = current_user.id

    if new_group.save
      flash[:notice] = 'Successfully created'
      redirect_to '/'
    else
      flash[:alert] = 'Failed to create'
      render :new
    end

  end


  private

  def group_params
    params.require(:group).permit(:name, :icon)
  end

end
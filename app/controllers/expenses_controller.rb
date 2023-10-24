class ExpensesController < ApplicationController

  def new
    @expense = Expense.new
    @groups = Group.all.pluck(:name, :id)
    1.times { @expense.expenses_groups.build }
  end

  def create
    new_expense = Expense.new(expense_params)
    new_expense.author_id = current_user.id
    
    puts '==============================='
    puts new_expense.name
    puts expense_params.keys
    puts '==============================='

    if new_expense.save
      flash[:notice] = 'Successfull created'
      # redirect_to user_group_path(user_id: current_user.id, id: new_expense.expenses_groups.first.group_id)
    else
      flash[:alert] = 'Failed to create'
      render :new
    end

  end

  private
  def expense_params
    params.require(:expense).permit(:name, expenses_groups_attributes: [:id, :group_id, :amount, :_destroy])
  end

end
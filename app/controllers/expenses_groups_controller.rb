class ExpensesGroupsController < ApplicationController
  def index
    @expenses_groups = ExpensesGroup.where(group_id: params[id])
  end
end

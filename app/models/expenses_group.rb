class ExpensesGroup < ApplicationRecord
  after_create :add_expense

  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :expense, foreign_key: 'expense_id'
  belongs_to :group, foreign_key: 'group_id'

  private

  def add_expense
    expense = Expense.find(expense_id)
    expense.update(amount: expense.amount + amount)
  end
end

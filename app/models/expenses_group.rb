class ExpensesGroup < ApplicationRecord

  validates :amount, numericality: { greater_than_or_equal_to: 0 }  

  belongs_to :expense, foreign_key: 'expense_id'
  belongs_to :good, foreign_key: 'good_id'
end
class Expense < ApplicationRecord

  validates :name, presence: true
  validates :amount, numericality: {greater_than_or_equal_to: 0}

  belongs_to :user, foreign_key: 'author_id'
  has_many :expenses_groups, dependent: :destroy
end

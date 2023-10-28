class Expense < ApplicationRecord
  validates :name, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :user, foreign_key: 'author_id'
  has_many :expenses_groups, inverse_of: :expense, dependent: :destroy

  # For nested form
  accepts_nested_attributes_for :expenses_groups,
                                allow_destroy: true,
                                reject_if: ->(attributes) { attributes['amount'].eql?('0.0') }
end

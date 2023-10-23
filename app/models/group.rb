class Group < ApplicationRecord
  validates :name, presence: true
  validates :icon, presence: true

  belongs_to :user, foreign_key: 'user_id'
  has_many :expenses_groups, dependent: :destroy
end
class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.string :name, null: false, default: ""
      t.float :amount, null: false, default: 0
      t.belongs_to :author, null: false, foreign_key: {to_table: :users}

      t.timestamps
    end

    create_table :groups do |t|
      t.string :name, null: false, default: ""
      t.string :icon, null: false, default: ""
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end

    # this table existing because of many-to-many association of Good and Groups
    create_table :expenses_groups do |t|
      t.float :amount, null: false, default: 0

      t.belongs_to :expense, null: false, foreign_key: true
      t.belongs_to :group, null: false, foreign_key: true

      t.timestamps
    end

  end
end

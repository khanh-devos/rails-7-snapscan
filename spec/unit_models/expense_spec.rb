require 'rails_helper'

RSpec.describe Expense do
  before(:all) do
    @user = User.create(
      name: 'Peter',
      email: 'peter@gmail.com',
      password: '@manda123'
    )

    @group = Group.create(user_id: @user.id, name: 'food', icon: 'icon link')
    @expense = Expense.create(id: 1, author_id: @user.id, name: 'exp1', amount: 0)

    @expense_gr1 = ExpensesGroup.create(
      expense_id: 1,
      group_id: @group.id,
      amount: 10
    )
    @expense_gr2 = ExpensesGroup.create(
      expense_id: 1,
      group_id: @group.id,
      amount: 20
    )
  end

  it 'name should be present' do
    @expense.name = nil
    expect(@expense).to_not be_valid
  end

  it 'amount should be present' do
    @expense.amount = nil
    expect(@expense).to_not be_valid
  end

  it 'should belong to author' do
    assc = described_class.reflect_on_association(:user)
    expect(assc.macro).to eq :belongs_to
  end

  it 'should have many expense groups' do
    assc = described_class.reflect_on_association(:expenses_groups)
    expect(assc.macro).to eq :has_many
  end
end

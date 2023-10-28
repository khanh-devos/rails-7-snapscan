require 'rails_helper'

RSpec.describe ExpensesGroup do
  before(:all) do
    @user = User.create(
      name: 'Peter',
      email: 'peter@gmail.com',
      password: '@manda123'
    )

    @group = Group.create(user_id: @user.id, name: 'food', icon: 'icon link')
    @expense = Expense.create(id: 1, author_id: @user.id, name: 'exp1')

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

  it 'amount should be present' do
    @expense_gr1.amount = nil
    expect(@expense_gr1).to_not be_valid
  end

  it 'quantity should be an integer' do
    @expense_gr1.amount = 'string'
    expect(@expense_gr1).to_not be_valid
  end

  it 'should belong to @expense' do
    assc = described_class.reflect_on_association(:expense)
    expect(assc.macro).to eq :belongs_to
  end

  it 'should belong to @group' do
    assc = described_class.reflect_on_association(:group)
    expect(assc.macro).to eq :belongs_to
  end

  it 'check method "add_expense" => amount should equal to 30.0' do
    exp = Expense.find(@expense.id)
    expect(exp.amount).to eql(30.0)
  end
end

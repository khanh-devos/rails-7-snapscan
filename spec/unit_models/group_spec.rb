require 'rails_helper'

RSpec.describe Group do
  before(:all) do
    @user = User.create(
        name: 'Peter',
        email: 'peter@gmail.com', 
        password: '@manda123'
    )
    
    @group = Group.create(user_id: @user.id, name: 'food', icon: 'icon link')
    @expense = Expense.create(author_id: @user.id, name: 'exp1')

    @expense_gr1 = ExpensesGroup.create(
        expense_id: @expense.id,
        group_id: @group.id,
        amount: 10
    )
    @expense_gr2 = ExpensesGroup.create(
        expense_id: @expense.id,
        group_id: @group.id,
        amount: 20
    )
  end

  it 'name should be present' do
    @group.name = nil
    expect(@group).to_not be_valid
  end

  it 'icon should be present' do
    @group.icon = nil
    expect(@group).to_not be_valid
  end


  it 'should belong to user' do
    assc = described_class.reflect_on_association(:user)
    expect(assc.macro).to eq :belongs_to
  end

  it 'should have many expenses_groups' do
    assc = described_class.reflect_on_association(:expenses_groups)
    expect(assc.macro).to eq :has_many
  end
end

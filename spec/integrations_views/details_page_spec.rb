require 'rails_helper'

RSpec.describe 'Group Details page', type: :feature do
  context 'group#show' do
    before do
      @user = User.create(id: 100, name: 'user1',
                          email: 'bio1@gmail.com', password: 'photo1@bc')

      @group = Group.create(id: 100, user_id: 100, name: 'food', icon: 'icon link')
      @expense = Expense.create(author_id: 100, name: 'exp1', amount: 0)

      @expense_gr1 = ExpensesGroup.create(expense_id: @expense.id, group_id: @group.id, amount: 10)
      @expense_gr2 = ExpensesGroup.create(expense_id: @expense.id, group_id: @group.id, amount: 20)

      # First of all, log in
      visit '/users/sign_in'
      within('form') do
        fill_in 'user_email', with: 'bio1@gmail.com'
        fill_in 'user_password', with: 'photo1@bc'
      end

      click_button 'Log in'
      visit('/users/100/groups/100')
    end

    it 'renders a list of transactions of the group "exp1"' do
      expect(page).to have_content('DETAILS')
      expect(page).to have_content('Exp1')
    end

    it 'check link-btn "new transaction"' do
      expect(page).to have_link('NEW TRANSACTION')
    end

    it 'click link-btn "new transaction" to show a expense#create page' do
      click_link('NEW TRANSACTION')
      expect(page).to have_content('NEW TRANSACTION')
      expect(page).to have_button('Submit')
    end
  end
end

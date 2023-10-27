require 'rails_helper'

RSpec.describe 'Group page', type: 'feature' do
  describe 'test group#show' do
    before :each do
      @user = User.create(id: 100, name: 'user1',
                          email: 'bio1@gmail.com', password: 'photo1@bc')

      @group = Group.create(id: 100, user_id: 100, name: 'food', icon: 'icon link')
      @expense = Expense.create(author_id: 100, name: 'exp1', amount: 0)

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

      # First of all, log in
      visit '/users/sign_in'
      within('form') do
        fill_in 'user_email', with: 'bio1@gmail.com'
        fill_in 'user_password', with: 'photo1@bc'
      end

      click_button 'Log in'
    end

    it 'can enter home page with the title CATEGORIES' do
      visit '/home'
      expect(page).to have_content('CATEGORIES')
    end

    it "check button 'Log Out' works fine" do
      visit '/home'
      click_link('Log Out')
      expect(page).not_to have_content('TRANSACTIONS')
    end

    it "show btn 'ADD NEW CATEGORY'" do
      expect(page).to have_link('ADD NEW CATEGORY')
    end

    it "click btn 'ADD NEW CATEGORY'" do
      click_link 'ADD NEW CATEGORY'
      expect(page).to have_selector('form', count: 1)
      expect(page).to have_button('Add')
    end

    it 'click on one group to visit its details page' do
      visit('/users/100/groups/100')
      expect(page).to have_content('CATEGORY DETAILS')
    end
  end
end

require 'rails_helper'

RSpec.describe 'New Group page', type: 'feature' do
  describe 'test group#create' do
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
      visit '/home'
      click_on 'NEW CATEGORY'
    end

    it 'can enter home page with the title CATEGORIES' do
      expect(page).to have_selector('form', count: 1)
    end

    it "check button 'Log Out' works fine" do
      within('form') do
        fill_in 'group_name', with: 'new group'
        fill_in 'group_icon', with: 'new icon'
      end

      click_on 'Add'
      expect(page).to have_content('Successfully created')
    end
  end
end

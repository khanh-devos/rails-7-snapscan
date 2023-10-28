require 'rails_helper'

RSpec.describe 'Home page', type: 'feature' do
  describe 'test user#show' do
    before :each do
      @user1 = User.create(name: 'user1',
                           email: 'bio1@gmail.com', password: 'photo1@bc')
      @user2 = User.create(name: 'user2',
                           email: 'bio2@gmail.com', password: 'photo2@bc')
    end

    it "check button 'Log In' failed with wrong email" do
      visit '/users/sign_in'
      within('form') do
        fill_in 'user_email', with: 'biox@gmail.com'
        fill_in 'user_password', with: 'photo1@bc'
      end
      click_on 'Log in'

      # cannot ente to other page
      expect(page).to have_content('Invalid Email or password.')
    end

    it "check button 'Log In' failed with wrong password" do
      visit '/users/sign_in'
      within('form') do
        fill_in 'user_email', with: 'bio1@gmail.com'
        fill_in 'user_password', with: 'photo1@bc123'
      end
      click_button 'Log in'

      expect(page).to have_content('Invalid Email or password.')
    end

    it "check button 'Log In' works fine" do
      visit '/users/sign_in'
      within('form') do
        fill_in 'user_email', with: 'bio1@gmail.com'
        fill_in 'user_password', with: 'photo1@bc'
      end

      click_button 'Log in'

      expect(page).to have_content('Signed in successfully.')
    end

    it "check button 'Sign Up' failed with unmatching password" do
      visit '/users/sign_up'
      within('form') do
        fill_in 'user_name', with: 'bio1'
        fill_in 'user_email', with: 'bio1@gmail.com'
        fill_in 'user_password', with: 'photo1@bc'
        fill_in 'user_password_confirmation', with: 'photo1@bc123'
      end
      click_button 'New'
      expect(page).to have_content('Password confirmation doesn\'t match Password')
    end

    it "check button 'Sign Up' failed with existing email" do
      visit '/users/sign_up'
      within('form') do
        fill_in 'user_name', with: 'bio1'
        fill_in 'user_email', with: 'bio1@gmail.com'
        fill_in 'user_password', with: 'photo1@bc'
        fill_in 'user_password_confirmation', with: 'photo1@bc'
      end
      click_button 'New'

      expect(page).to have_content('Email has already been taken')
    end

    it "check button 'Sign Up' failed with empty name" do
      visit '/users/sign_up'
      within('form') do
        fill_in 'user_email', with: 'bio1@gmail.com'
        fill_in 'user_password', with: 'photo1@bc'
        fill_in 'user_password_confirmation', with: 'photo1@bc'
      end
      click_button 'New'
      expect(page).to have_content('Name can\'t be blank')
    end

    it "check button 'Sign Up' works fine" do
      visit '/users/sign_up'
      within('form') do
        fill_in 'user_name', with: 'bio1'
        fill_in 'user_email', with: 'bio3@gmail.com'
        fill_in 'user_password', with: 'photo1@bc'
        fill_in 'user_password_confirmation', with: 'photo1@bc'
      end
      click_button 'New'
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end
end

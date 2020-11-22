require 'rails_helper'

RSpec.describe 'user registrations', type: :system do
  
  describe 'user registrations' do
    context 'normal' do
      it 'passes with a right user' do
        visit new_user_registration_path
        expect(page).to have_content('新規登録')
        fill_in 'user_email', with: 'test@gmail.com'
        fill_in 'user_name', with: 'test user'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        click_on 'commit'
        expect(page).to have_content('アカウント登録が完了しました')
      end
    end

    context 'abnormal' do
      it "doesn't pass when password or mail address or name is blank" do
        visit new_user_registration_path
        expect(page).to have_content('新規登録')
        click_on 'commit'
        expect(page).to have_content('メールアドレス が空欄です')
        expect(page).to have_content('名前 が空欄です')
        expect(page).to have_content('パスワード が空欄です')
      end
    end
  end
end
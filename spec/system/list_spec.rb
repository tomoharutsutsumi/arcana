require 'rails_helper'

RSpec.describe 'manage lists', type: :system do
  let!(:user) { create(:user) }

  describe 'normal' do
    before do
      sign_in_as(user)
    end

    it 'can be added as a new list' do
      expect(page).to have_content('Myリストがまだ追加されていません')
      click_on '+リスト追加'
      expect(page).to have_content('リストを登録する')
      fill_in 'list_title', with: 'list1'
      expect{ click_on 'commit' }.to change{ user.lists.count }.by(1)
      expect(user.lists.last.title).to eq 'list1'
      expect(page).to have_content('リストを登録しました')
      expect(page).to have_content('list1')
    end

    it 'can be edited as an edited list' do
      expect(page).to have_content('Myリストがまだ追加されていません')
      click_on '+リスト追加'
      expect(page).to have_content('リストを登録する')
      fill_in 'list_title', with: 'list1'
      click_on 'commit'
      expect(page).to have_content('list1')
      click_on '編集'
      fill_in 'list_title', with: ''
      fill_in 'list_title', with: 'list2'
      click_on 'commit'
      expect(user.lists.last.title).to eq 'list2'
      expect(page).to have_content('リストを編集しました')
      expect(page).to have_content('list2')
    end

    it 'can be deleted' do
      expect(page).to have_content('Myリストがまだ追加されていません')
      click_on '+リスト追加'
      expect(page).to have_content('リストを登録する')
      fill_in 'list_title', with: 'list1'
      click_on 'commit'
      expect(user.lists.last.title).to eq 'list1'
      expect(page).to have_content('リストを登録しました')
      expect(page).to have_content('list1')
      click_on '削除'
      alert = page.driver.browser.switch_to.alert
      alert.accept
      expect(page).to have_content('リストを削除しました')
      expect(user.lists.count).to eq 0
    end
  end

  describe 'abnormal' do
    it "doesn't pass when the title is blank" do
      sign_in_as(user)
      expect(page).to have_content('Myリストがまだ追加されていません')
      click_on '+リスト追加'
      click_on 'commit'
      expect(page).to have_content('リスト名 が空欄です')
    end
  end
end
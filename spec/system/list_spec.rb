require 'rails_helper'

RSpec.describe 'manage lists', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user, name: 'Other Person', email: 'test1@gmail.com') }

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

    it 'can be deleted although it is allowed to be seen from someone' do
      # lists and restaurants are added
      expect(page).to have_content('Myリストがまだ追加されていません')
      click_on '+リスト追加'
      expect(page).to have_content('リストを登録する')
      fill_in 'list_title', with: 'list1'
      click_on 'commit'
      expect(user.lists.last.title).to eq 'list1'
      expect(page).to have_content('リストを登録しました')
      expect(page).to have_content('list1')
      click_on '+リスト追加'
      expect(page).to have_content('リストを登録する')
      fill_in 'list_title', with: 'list2'
      click_on 'commit'
      expect(user.lists.last.title).to eq 'list2'
      expect(page).to have_content('リストを登録しました')
      expect(page).to have_content('list2')
      click_on 'list1'
      expect(page).to have_content('まだお店が登録されていません')
      click_on '+お店を登録する'
      fill_in 'name', with: 'もぅあしびー'
      click_on 'commit'
      click_on '登録する', match: :first 
      sleep 3
      expect(page).to have_content('お店を登録しました')
      check 'katakana'
      fill_in 'name', with: 'イルブリオ'
      click_on 'commit', match: :first
      click_on '登録する', match: :first
      expect(page).to have_content('お店を登録しました')
      click_on 'Myリスト'
      click_on 'list2'
      expect(page).to have_content('まだお店が登録されていません')
      click_on '+お店を登録する'
      fill_in 'name', with: 'ケンタッキー'
      click_on 'commit'
      click_on '登録する', match: :first 
      expect(page).to have_content('お店を登録しました')
      fill_in 'name', with: '喜鈴'
      click_on 'commit'
      click_on '登録する', match: :first 
      expect(page).to have_content('お店を登録しました')
      click_on 'ログアウト'

      # send a request to this user
      sign_in_as(other_user)
      click_on '検索'
      expect(page).to have_content 'ユーザー検索'
      fill_in 'name', with: 'John Doe'
      click_on '検索', match: :first
      expect(page).to have_content('John Doe')
      expect(page).to have_content('リクエスト')
      click_on 'リクエスト'
      expect(page).to have_content('John Doe')
      click_on '+リクエスト'
      expect(page).to have_content('リクエストを送信しました')
      click_on 'ログアウト'

      # permit the request 
      sign_in_as(user)
      expect(page).to have_content 'ログインしました'
      click_on '検索'
      expect(page).to have_content('Other Person')
      click_on '承認'
      expect(page).to have_content('リクエストを承認しました')
      check 'list1'
      check 'list2'
      click_on '共有する'
      expect(page).to have_content('Other Person')
      expect(page).to have_content('承認済み')
      expect(page).to have_content('list1')
      expect(page).to have_content('list2')
      click_on 'Myリスト'
      click_on '削除', match: :first
      alert = page.driver.browser.switch_to.alert
      alert.accept
      expect(page).to have_content('削除しました')
      expect(user.lists.count).to eq 1
      expect(ArchivedList.last.title).to eq 'list1'
      expect(ArchivedList.last.archived_restaurants.first.name).to eq 'もぅあしびー'
      expect(ArchivedList.last.archived_restaurants.last.name).to eq 'IL Brio'
      expect(Archiving.last.user_id).to eq other_user.id

      # list and restaurants can be archived and other user can see check them out
      click_on 'ログアウト'
      sign_in_as(other_user)
      click_on('リスト一覧')
      expect(page).to have_content('list1')
      expect(page).to have_content('list2')
      click_on 'list1'
      expect(page).to have_content('もぅあしびー')
      expect(page).to have_content('IL Brio')
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
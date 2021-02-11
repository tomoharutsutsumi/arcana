require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe 'manage lists', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user, name: 'Other Person', email: 'test1@gmail.com') }
  let(:list) { create(:list, user: user)}

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
      find('.fa-edit').click
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
      find('.fa-trash').click
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
      expect(page).to have_content('リストを登録しました')
      expect(user.lists.last.title).to eq 'list1'
      expect(page).to have_content('list1')
      click_on '+リスト追加'
      expect(page).to have_content('リストを登録する')
      fill_in 'list_title', with: 'list2'
      click_on 'commit'
      expect(page).to have_content('リストを登録しました')
      expect(user.lists.last.title).to eq 'list2'
      expect(page).to have_content('list2')
      click_on 'list1'
      expect(page).to have_content('まだお店が登録されていません')
      click_on '+お店を登録する'
      fill_in 'freeword', with: 'もぅあしびー'
      page.all(:css, '.fa-search')[0].click
      sleep 5
      click_on '登録する', match: :first 
      expect(page).to have_content('お店を登録しました')
      # check 'katakana'
      fill_in 'freeword', with: 'イルブリオ'
      page.all(:css, '.fa-search')[0].click
      click_on '登録する', match: :first
      expect(page).to have_content('お店を登録しました')
      click_on 'Myリスト'
      click_on 'list2'
      expect(page).to have_content('まだお店が登録されていません')
      click_on '+お店を登録する'
      fill_in 'freeword', with: 'ケンタッキー'
      page.all(:css, '.fa-search')[0].click
      click_on '登録する', match: :first 
      expect(page).to have_content('お店を登録しました')
      fill_in 'freeword', with: '喜鈴'
      page.all(:css, '.fa-search')[0].click
      click_on '登録する', match: :first 
      expect(page).to have_content('お店を登録しました')
      logout

      # send a request to this user

      # this is a deleted function
      # sign_in_as(other_user)
      # click_on '検索'
      # expect(page).to have_content '共有履歴'
      # fill_in 'name', with: 'John Doe'
      # click_on '検索', match: :first
      # expect(page).to have_content('John Doe')
      # expect(page).to have_content('リクエスト')
      # click_on 'リクエスト'
      # expect(page).to have_content('John Doe')
      # click_on '+リクエスト'
      # expect(page).to have_content('リクエストを送信しました')
      # click_on 'ログアウト'

      # permit the request 
      # this is a deleted function
      # sign_in_as(user)
      # expect(page).to have_content 'ログインしました'
      # click_on '検索'
      # expect(page).to have_content('Other Person')
      # click_on '承認'
      # expect(page).to have_content('リクエストを承認しました')
      # check 'list1'
      # check 'list2'
      # click_on '共有する'
      # expect(page).to have_content('Other Person')
      # expect(page).to have_content('承認済み')
      # expect(page).to have_content('list1')
      # expect(page).to have_content('list2')
      # click_on 'Myリスト'
      # page.all(:css, '.fa-trash')[0].click
      # alert = page.driver.browser.switch_to.alert
      # alert.accept
      # expect(page).to have_content('削除しました')
      # expect(user.lists.count).to eq 1
      # expect(ArchivedList.last.title).to eq 'list1'
      # expect(ArchivedList.last.archived_restaurants.first.name).to eq 'もぅあしびー'
      # expect(ArchivedList.last.archived_restaurants.last.name).to eq 'IL Brio'
      # expect(Archiving.last.user_id).to eq other_user.id

      # list and restaurants can be archived and other user can see check them out
      # this is a deleted function
      # find('.fa-search').click
      # click_on 'ログアウト'
      # sign_in_as(other_user)
      # click_on('リスト一覧')
      # expect(page).to have_content('list1')
      # expect(page).to have_content('list2')
      # click_on 'list1'
      # expect(page).to have_content('もぅあしびー')
      # expect(page).to have_content('IL Brio')
    end

    it 'can be shared with URL and user can register through the list with facebook' do
      expect(page).to have_content('Myリストがまだ追加されていません')
      click_on '+リスト追加'
      expect(page).to have_content('リストを登録する')
      fill_in 'list_title', with: 'list11'
      expect{ click_on 'commit' }.to change{ user.lists.count }.by(1)
      expect(user.lists.last.title).to eq 'list11'
      expect(page).to have_content('リストを登録しました')
      expect(page).to have_content('list11')
      click_on 'list11'
      # expect(page).to have_content('共有リンクを発行する')
      # click_on '共有リンクを発行する'
      # expect(page).to have_content('共有リンクが発行されました')
      click_on 'ログアウト'
      expect(page).to have_content('ログアウトしました')
      OmniAuth.config.mock_auth[:facebook] = nil
      Rails.application.env_config['omniauth.auth'] = facebook_mock
      visit shared_list_path(user.lists.last.id, share_hash: user.lists.last.share_hash)
      expect(page).to have_content('まだお店が登録されていません')
      expect(page).to have_content('ログインしてリストを保存する')
      click_on 'ログインしてリストを保存する'
      expect(page).to have_content('新規登録')
      click_link "Facebookでログイン"
      expect(page).to have_content('Myリスト')
      expect(User.last.name).to eq 'mockuser'
      click_on 'リスト一覧'
      expect(page).to have_content('list11')
    end

    it 'can be shared with URL and user can sign up through the list with normal form' do
      expect(page).to have_content('Myリストがまだ追加されていません')
      click_on '+リスト追加'
      expect(page).to have_content('リストを登録する')
      fill_in 'list_title', with: 'list11'
      expect{ click_on 'commit' }.to change{ user.lists.count }.by(1)
      expect(user.lists.last.title).to eq 'list11'
      expect(page).to have_content('リストを登録しました')
      expect(page).to have_content('list11')
      click_on 'list11'
      click_on 'ログアウト'
      expect(page).to have_content('ログアウトしました')
      visit shared_list_path(user.lists.last.id, share_hash: user.lists.last.share_hash)
      expect(page).to have_content('まだお店が登録されていません')
      expect(page).to have_content('新規登録してリストを保存する')
      click_on '新規登録してリストを保存する'
      expect(page).to have_content('新規登録')
      fill_in 'user_email', with: 'test@gmail.com'
      fill_in 'user_name', with: 'test user'
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_on 'commit'
      expect(page).to have_content('アカウント登録が完了しました')
      click_on 'リスト一覧'
      expect(page).to have_content('list11')
    end

    it 'can be shared with URL and user can sign in through the list with normal form' do
      expect(page).to have_content('Myリストがまだ追加されていません')
      click_on '+リスト追加'
      expect(page).to have_content('リストを登録する')
      fill_in 'list_title', with: 'list11'
      expect{ click_on 'commit' }.to change{ user.lists.count }.by(1)
      expect(user.lists.last.title).to eq 'list11'
      expect(page).to have_content('リストを登録しました')
      expect(page).to have_content('list11')
      click_on 'list11'
      click_on 'ログアウト'
      expect(page).to have_content('ログアウトしました')
      visit shared_list_path(user.lists.last.id, share_hash: user.lists.last.share_hash)
      expect(page).to have_content('まだお店が登録されていません')
      expect(page).to have_content('ログインしてリストを保存する')
      click_on 'ログインしてリストを保存する'
      expect(page).to have_content('ログイン')
      fill_in 'user_email', with: other_user.email
      fill_in 'user_password', with: other_user.password
      click_on 'commit'
      expect(page).to have_content('ログインしました')
      click_on 'リスト一覧'
      expect(page).to have_content('list11')
    end

    it 'can be shared with URL and logined user can check the list' do
      expect(page).to have_content('Myリストがまだ追加されていません')
      click_on '+リスト追加'
      expect(page).to have_content('リストを登録する')
      fill_in 'list_title', with: 'list11'
      expect{ click_on 'commit' }.to change{ user.lists.count }.by(1)
      expect(user.lists.last.title).to eq 'list11'
      expect(page).to have_content('リストを登録しました')
      expect(page).to have_content('list11')
      click_on 'ログアウト'
      expect(page).to have_content('ログアウトしました')
      # list
      # logout
      visit new_user_session_path
      expect(page).to have_content('ログイン')
      fill_in 'user_email', with: other_user.email
      fill_in 'user_password', with: other_user.password
      click_on 'commit'
      expect(page).to have_content('ログインしました')
      visit shared_list_path(user.lists.last.id, share_hash: user.lists.last.share_hash)
      expect(page).to have_content('このリストをMyリストに保存する')
      click_on 'このリストをMyリストに保存する'
      expect(page).to have_content 'リストに登録しました'
      click_on 'リスト一覧'
      expect(page).to have_content('list11')
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
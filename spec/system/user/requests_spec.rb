require 'rails_helper'

RSpec.describe 'manage requests', type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user, name: 'Other Person', email: 'test1@gmail.com') }
  let!(:list1) { create(:list, user: other_user, title: 'list1') }
  let!(:list2) { create(:list, user: other_user, title: 'list2') }
  let!(:list3) { create(:list, user: other_user, title: 'list3') }

  describe 'normal' do
    before do
      sign_in_as(user)
    end

    it 'can be send through searching and can be permitted' do
      expect(page).to have_content 'ログインしました'
      click_on '検索'
      expect(page).to have_content '共有履歴'
      fill_in 'name', with: 'Other Person'
      click_on '検索', match: :first
      expect(page).to have_content('Other Person')
      expect(page).to have_content('リクエスト')
      click_on 'リクエスト'
      expect(page).to have_content('Other Person')
      click_on '+リクエスト'
      expect(page).to have_content('リクエストを送信しました')
      expect(PermissionRequest.last.sent_from_id).to eq user.id
      expect(PermissionRequest.last.sent_to_id).to eq other_user.id
      expect(PermissionRequest.last.status).to eq PermissionRequest::DEFAULT
      fill_in 'name', with: 'Other Person'
      click_on '検索', match: :first
      expect(page).to have_content('リクエスト済み')
      click_on 'ログアウト'
      sign_in_as(other_user)
      click_on '検索'
      expect(page).to have_content('John Doe')
      click_on '承認'
      expect(page).to have_content('承認したユーザーと共有するリストを選択してください') 
      expect(page).to have_content('リクエストを承認しました')
      expect(PermissionRequest.last.status). to eq PermissionRequest::PERMITTED
      check 'list1'
      check 'list2'
      click_on '共有する'
      expect(page).to have_content('John Doe')
      expect(page).to have_content('承認済み')
      expect(page).to have_content('list1')
      expect(page).to have_content('list2')
      expect(page).not_to have_content('list3')
      expect(PermissionList.first.permission_request_id). to eq PermissionRequest.first.id
      expect(PermissionList.last.permission_request_id). to eq PermissionRequest.last.id
      expect(PermissionList.first.list.title). to eq 'list1'
      expect(PermissionList.last.list.title). to eq 'list2'
      click_on 'ログアウト'
      sign_in_as(user)
      click_on 'リスト一覧'
      expect(page).to have_content('list1')
      expect(page).to have_content('list2')
      expect(page).not_to have_content('list3')
    end

    it 'can be send through searching and can be rejected' do
      expect(page).to have_content 'ログインしました'
      click_on '検索'
      expect(page).to have_content '共有履歴'
      fill_in 'name', with: 'Other Person'
      click_on '検索', match: :first
      expect(page).to have_content('Other Person')
      expect(page).to have_content('リクエスト')
      click_on 'リクエスト'
      expect(page).to have_content('Other Person')
      click_on '+リクエスト'
      expect(page).to have_content('リクエストを送信しました')
      expect(PermissionRequest.last.sent_from_id).to eq user.id
      expect(PermissionRequest.last.sent_to_id).to eq other_user.id
      expect(PermissionRequest.last.status).to eq PermissionRequest::DEFAULT
      fill_in 'name', with: 'Other Person'
      click_on '検索', match: :first
      expect(page).to have_content('リクエスト済み')
      click_on 'ログアウト'
      sign_in_as(other_user)
      click_on '検索'
      expect(page).to have_content('John Doe')
      click_on '非承認'
      expect(PermissionRequest.last.status).to eq PermissionRequest::REJECTED
      click_on 'ログアウト'
      sign_in_as(user)
      click_on 'リスト一覧'
      expect(page).not_to have_content('list1')
      expect(page).not_to have_content('list2')
      expect(page).not_to have_content('list3')
    end
  end

  describe 'abnormal' do
    before do
      sign_in_as(user)
    end

    # TODO 承認済みのところでバックしたらどうすんのか=> 承認ずみを後からいじれるようにする。
  end
end
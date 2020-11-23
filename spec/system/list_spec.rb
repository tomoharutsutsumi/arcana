require 'rails_helper'

RSpec.describe 'manage list', type: :system do
  let!(:user) { create(:user) }

  describe 'normal' do
    it 'can add a new list' do
      sign_in_as(user)
      expect(page).to have_content('Myリストがまだ追加されていません')
      click_on '+リスト追加'
      expect(page).to have_content('リストを登録する')
      fill_in 'list_title', with: 'list1'
      expect{ click_on 'commit' }.to change{ user.lists.count }.by(1)
      expect(user.lists.last.title).to eq 'list1'
      expect(page).to have_content('リストを登録しました')
      expect(page).to have_content('list1')
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
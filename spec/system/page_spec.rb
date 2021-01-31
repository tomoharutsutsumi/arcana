require 'rails_helper'

RSpec.describe 'page transitions', type: :system do
  let!(:user) { create(:user) }

  describe 'normal' do
    before do
      sign_in_as(user)
    end

    it 'pushes header, the page transits to My list page' do
      click_on 'リスト一覧'
      expect(page).to have_content('許可されたリストはありません')
      click_on 'アルカナ'
      expect(page).to have_content('のMyリスト')
    end
  end
end
require 'rails_helper'

RSpec.describe 'manage restaurants', type: :system do
  let!(:user) { create(:user) }
  let!(:list) { create(:list, user: user) }

  describe 'normal' do
    before do
      sign_in_as(user)
    end

    it 'can be added as a restaurant' do
      click_on "#{list.title}"
      expect(page).to have_content('まだお店が登録されていません')
      click_on '+お店を登録する'
      fill_in 'name', with: 'マクドナルド'
      click_on 'commit'
      click_on '登録する', match: :first 
      expect(page).to have_content('お店を登録しました')
      expect(list.restaurants.count).to eq 1
      expect(list.restaurants.last.name).to eq 'マクドナルド 柏高島屋ステーションモール店'
      click_on 'Myリスト'
      expect(find('#number')).to have_content 1
    end

    it 'can be added as a restaurant with katakana' do
      click_on "#{list.title}"
      expect(page).to have_content('まだお店が登録されていません')
      click_on '+お店を登録する'
      fill_in 'name', with: 'イルブリオ'
      click_on 'commit'
      expect(page).to have_content('該当するお店が見つかりませんでした')
      check 'katakana'
      fill_in 'name', with: 'イルブリオ'
      click_on 'commit', match: :first
      click_on '登録する', match: :first
      expect(page).to have_content('お店を登録しました')
      expect(list.restaurants.count).to eq 1
      expect(list.restaurants.last.name).to eq 'IL Brio'
      click_on 'Myリスト'
      expect(find('#number')).to have_content 1
    end

    it 'can be added when no restanrants are found' do
      click_on "#{list.title}"
      expect(page).to have_content('まだお店が登録されていません')
      click_on '+お店を登録する'
      fill_in 'name', with: 'test1'
      click_on 'commit'
      expect(page).to have_content('お店が見つかりませんでしたか？')
      fill_in 'restaurant_name', with: 'test_name'
      fill_in 'restaurant_address', with: 'test_address'
      fill_in 'restaurant_category', with: 'test_category'
      fill_in 'restaurant_budget', with: 1000
      fill_in 'restaurant_tel', with: '080-1234-5678'
      fill_in 'restaurant_combined_access', with: 'test_access'
      fill_in 'restaurant_opentime', with: '3:00 pm ~ 12:00 pm'
      fill_in 'restaurant_holiday', with: 'Friday'
      fill_in 'restaurant_url', with: 'https://test/test'
      find('#submit').click
      expect(page).to have_content('お店を登録しました')
      expect(list.restaurants.count).to eq 1
      expect(list.restaurants.last.name).to eq 'test_name'
      click_on 'Myリスト'
      expect(find('#number')).to have_content 1
    end

    it 'can be seen in detail' do
      click_on "#{list.title}"
      expect(page).to have_content('まだお店が登録されていません')
      click_on '+お店を登録する'
      fill_in 'name', with: 'マクドナルド'
      click_on 'commit'
      click_on '登録する', match: :first 
      expect(page).to have_content('お店を登録しました')
      click_on 'Myリスト'
      click_on "#{list.title}"
      expect(page).to have_content('店名')
      click_on '詳細'
      expect(page).to have_content 'マクドナルド 柏高島屋ステーションモール店'
      expect(page).to have_content 'ハンバーガー'
      expect(page).to have_content '〒277-8550 千葉県柏市末広町1-1 柏高島屋ステーションモール'
      expect(page).to have_content '500円'
      expect(page).to have_content 'ＪＲ常磐線柏駅西口徒歩1分'
      expect(page).to have_content '5:00～23:00、5:00～10:30((朝マック))'
      expect(page).to have_content '不定休日あり ※テナント休業日に準ずる'
      expect(page).to have_content 'おすすめコース'
      expect(page).to have_content '同行者'
      expect(page).to have_content 'コメント'
      expect(page).to have_content 'URL'
    end

    it 'can be edited as an edited restaurant' do
      click_on "#{list.title}"
      expect(page).to have_content('まだお店が登録されていません')
      click_on '+お店を登録する'
      fill_in 'name', with: 'マクドナルド'
      click_on 'commit'
      click_on '登録する', match: :first 
      expect(page).to have_content('お店を登録しました')
      click_on 'Myリスト'
      click_on "#{list.title}"
      expect(page).to have_content('店名')
      click_on '編集'
      fill_in 'restaurant[name]', with: ''
      fill_in 'restaurant[name]', with: '編集されたマクドナルド'
      click_on 'お店を編集'
      expect(page).to have_content('お店を編集しました')
      expect(list.restaurants.last.name).to eq '編集されたマクドナルド'
    end

    it 'can be deleted' do
      click_on "#{list.title}"
      expect(page).to have_content('まだお店が登録されていません')
      click_on '+お店を登録する'
      fill_in 'name', with: 'マクドナルド'
      click_on 'commit'
      click_on '登録する', match: :first 
      expect(page).to have_content('お店を登録しました')
      click_on 'Myリスト'
      click_on "#{list.title}"
      expect(page).to have_content('店名')
      click_on '削除'
      alert = page.driver.browser.switch_to.alert
      alert.accept
      expect(page).to have_content('お店を削除しました')
      expect(page).to have_content('まだお店が登録されていません')
      expect(list.restaurants.count).to eq 0
    end
  end

  describe 'abnormal' do
    
  end
end
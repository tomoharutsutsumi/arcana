require 'rails_helper'

RSpec.describe 'manage original_restaurants', type: :system do
  let!(:admin_user) { create(:admin_user) }
  let!(:user) { create(:user) }

  it 'can be created from admins view' do
    visit new_admin_original_restaurant_path
    fill_in 'admin_user_email', with: admin_user.email
    fill_in 'admin_user_password', with: admin_user.password
    click_on 'commit'
    expect(page).to have_content('レストラン')
    click_on 'レストラン'
    expect(page).to have_content '新規'
    fill_in 'original_restaurant_price', with: 1000
    fill_in 'original_restaurant_url', with: 'https://example.com'
    fill_in 'original_restaurant_category', with: 'テストカテゴリー'
    fill_in 'original_restaurant_place', with: 'テスト場所'
    fill_in 'original_restaurant_tel', with: '090-1234-5678'
    fill_in 'original_restaurant_opentime', with: '9:00~10:00'
    fill_in 'original_restaurant_holiday', with: 'saturday'
    fill_in 'original_restaurant_combined_access', with: '東京都港区六本木'
    fill_in 'original_restaurant_name', with: 'test_res'
    expect(page).to have_field('original_restaurant_name', with: 'test_res')
    click_on 'Create レストラン'
    expect(page).to have_content 'OriginalRestaurantを作成しました。'
    sign_in_as(user)
    expect(page).to have_content('Myリストがまだ追加されていません')
    click_on '+リスト追加'
    expect(page).to have_content('リストを登録する')
    fill_in 'list_title', with: 'list1'
    click_on 'commit'
    expect(page).to have_content('リストを登録しました')
    expect(user.lists.last.title).to eq 'list1'
    expect(page).to have_content('list1')
    click_on 'list1'
    expect(page).to have_content('まだお店が登録されていません')
    click_on '+お店を登録する'
    fill_in 'freeword', with: 'test_res'
    page.all(:css, '.fa-search')[0].click
    click_on '登録する', match: :first 
    expect(page).to have_content('お店を登録しました')
    expect(user.lists.last.restaurants.last.name).to eq 'test_res'
    click_on '登録リストに戻る'
    expect(page).to have_content('test_res')
  end

  it 'can be requested from user' do
    sign_in_as(user)
    expect(page).to have_content('Myリストがまだ追加されていません')
    click_on '+リスト追加'
    expect(page).to have_content('リストを登録する')
    fill_in 'list_title', with: 'list1'
    click_on 'commit'
    expect(page).to have_content('リストを登録しました')
    expect(user.lists.last.title).to eq 'list1'
    expect(page).to have_content('list1')
    click_on 'list1'
    expect(page).to have_content('まだお店が登録されていません')
    click_on '+お店を登録する'
    fill_in 'freeword', with: 'llll'
    page.all(:css, '.fa-search')[0].click
    expect(page).to have_content('登録リクエスト')
    fill_in 'name', with: 'テストテストテスト'
    click_on 'リクエスト'
    expect(page).to have_content('リクエストを送りました')
    expect(ActionMailer::Base.deliveries.count).to eq 1
    sent_mail = ActionMailer::Base.deliveries.last
    expect(sent_mail.subject).to have_content '[アルカナ] お店登録のリクエストが届いています'
    expect(sent_mail.body).to include 'テストテストテスト'
  end
end
  
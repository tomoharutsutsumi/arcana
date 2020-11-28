module OmniauthMacros
  def facebook_mock
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      {
        provider: 'facebook',
        uid: '12345',
        info: {
          name: 'mockuser',
          email: 'test@gmail.com'
        },
        credentials: {
          token: 'hogefuga'
        }
      }
    )
  end
end

RSpec.configure do |config|
  if Rails.env.test?
    OmniAuth.config.test_mode = true
    config.include OmniauthMacros
  end
end
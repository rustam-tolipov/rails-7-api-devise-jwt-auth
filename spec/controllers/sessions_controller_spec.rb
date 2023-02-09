require 'rails_helper'

describe Api::V1::SessionsController, type: :request do
  let(:user) { create_user }
  let(:auth_token) { login_with_api(user) }
  let(:login_url) { '/api/v1/auth/login' }
  let(:logout_url) { '/api/v1/auth/logout' }

  context 'When logging in' do
    before do
      login_with_api(user)
    end

    it 'returns a token' do
      expect(auth_token).to be_present
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end
  end

  context 'When logging out' do
    before do
      auth_token = login_with_api(user)
      delete logout_url, headers: {
        Authorization: auth_token
      }
    end
  end

  context 'When password is missing' do
    before do
      post login_url, params: {
        user: {
          email: user.email,
          password: ''
        }
      }
    end

    it 'returns 401' do
      expect(response.status).to eq(401)
    end
  end
end

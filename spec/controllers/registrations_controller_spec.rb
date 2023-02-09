require 'rails_helper'

describe Api::V1::RegistrationsController, type: :request do
  let(:user) { build_user }
  let(:existing_user) { create_user }
  let(:signup_url) { '/api/v1/auth/signup' }

  context 'When creating a new user' do
    before do
      post signup_url,
           params: {
             user: {
              id: user.id,
              first_name: user.first_name,
              last_name: user.last_name,
              username: user.username,
              email: user.email,
              password: user.password,
              password_confirmation: user.password_confirmation
             }
           }
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end

    it 'returns the user email' do
      expect(json['email']).to eq(user.email)
    end
  end

  context 'When an email already exists' do
    before do
      post signup_url, params: {
        user: {
          first_name: existing_user.first_name,
          last_name: existing_user.last_name,
          email: existing_user.email,
          password: existing_user.password,
          password_confirmation: existing_user.password_confirmation
        }
      }
    end

    it 'returns 422' do
      expect(response.status).to eq(422)
    end

    it 'returns an error message' do
      expect(json.dig('errors', 'email'))
    end
  end
end

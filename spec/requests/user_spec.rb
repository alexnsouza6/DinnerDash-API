require 'rails_helper'

RSpec.describe 'User API', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:headers) do
    { 'Content-Type' => 'application/json' }
  end
  let(:params) do
    {
      'name': 'Smith',
      'username': 'Smithzão',
      'email': '123@email.com',
      'password': '123123',
      'password_confirmation': '123123'
    }
  end

  describe "POST /users" do
    before do
      post "/users", params: params.to_json, headers: headers
    end

    it 'returns 200 http status' do
      expect(response).to have_http_status(200)
    end

    it 'returns a json data for user' do
      expect(response.body).not_to be_nil
    end

    it 'creates a token for user' do
      expect(response.body).to include("token")
    end
  end

  describe "DELETE /users/id" do
    before do
      delete "/users/#{user.id}", params: {}, headers: headers
    end

    it 'returns 200 http status' do
      expect(response).to have_http_status(200)
    end

    it 'returns a success message' do
      expect(response.body).to include("message")
    end
  end
end

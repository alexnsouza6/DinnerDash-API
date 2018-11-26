require 'rails_helper'

RSpec.describe 'Session API', type: :request do
  let!(:user) { FactoryBot.create(:user) }
  let(:json_response) { JSON.parse(response.body) }
  let(:headers) do
    { 'Content-Type' => 'application/json' }
  end
  let(:params) do
    {
      email: user.email,
      password: user.password
    }
  end

  describe "POST /login" do
    describe 'when user exists...' do
      before do
        post "/login", params: params.to_json, headers: headers
      end
      it 'returns 200 http status' do
        expect(response).to have_http_status(200)
      end

      it 'returns a user' do
        expect(json_response['id']).to eq user.id
      end

      it 'returns a user with a not null token' do
        expect(json_response['token']).not_to be_nil
      end
    end

    describe 'when user does not exist...' do
      before do
        post "/login", params: {}, headers: headers
      end
      it 'returns 200 http status' do
        expect(response).to have_http_status(401)
      end

      it 'returns an error message' do
        expect(json_response['message']).to eq "Invalid E-mail or Password"
      end
    end
  end

  describe "DELETE /logout" do
    let(:headers_with_token) do
      {
        'Content-Type' => 'application/json',
        'Authorization' => "Bearer #{user.token}"
      }
    end
    before do
      post "/login", params: params.to_json, headers: headers
      user.token = "123123"
      user.save
      delete "/logout", params: {}, headers: headers_with_token
    end

    it "returns a 200 http status response" do
      expect(response).to have_http_status(200)
    end

    it "returns a message" do
      expect(json_response['message']).to eq "Bye bye, come back soon!"
    end
  end
end

require 'rails_helper'

RSpec.describe 'Session API', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:headers) do
    { 'Content-Type' => 'application/json' }
  end

  describe "POST /login" do
    before do
      allow(user).to receive(:token).and_return('123123')
      post "/login", params: user.to_json, headers: headers
    end

    it 'returns 200 http status' do
      expect(response).to have_http_status(200)
    end
  end
end

require 'rails_helper'

RSpec.describe 'User API', type: :request do
  let(:json_response) { JSON.parse(response.body) }
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
  let(:fake_params) do
    {
      'name': 'Smith',
      'username': 'Smithzão',
      'email': '123@email.com',
      'password': '123123'
    }
  end

  describe "POST /users" do
    describe "when user is valid..." do
      before do
          post "/users", params: params.to_json, headers: headers
      end

      it "returns 200 http status" do
        expect(response).to have_http_status(200)
      end

      it "returns a json data for user" do
        expect(json_response['name']).to eq params[:name]
      end

      it "creates a token for user" do
        expect(json_response['token']).not_to be_nil
      end
    end

    describe "when user is not valid" do
      before do
        post "/users", params: fake_params.to_json, headers: headers
      end
      it "returns 422 http status" do
        expect(response).to have_http_status(422)
      end

      it "returns a json data for user" do
        expect(json_response['errors']).not_to be_nil
      end
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
      expect(json_response['message']).to eq "User successfully destroyed"
    end
  end

  describe "PUT /users/id" do
    describe "when change is valid" do
      before do
        params[:name] = 'Chetter'
        put "/users/#{user.id}", params: params.to_json, headers: headers
      end

      it "returns a 200 http response" do
        expect(response).to have_http_status(200)
      end

      it "returns the updated user" do
        expect(json_response['name']).to eq 'Chetter'
      end
    end

    describe "when change is invalid" do
      before do
        put "/users/#{user.id}", params: user.to_json, headers: headers
      end

      it "returns 422 http status" do
        expect(response).to have_http_status(422)
      end

      it "returns a json with errors" do
        expect(json_response['errors']).to eq "Couldn't save user correctly"
      end
    end
  end

end

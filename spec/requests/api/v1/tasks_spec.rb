require 'rails_helper'

RSpec.describe 'Tasks API', type: :request do
  before { host! 'api.taskmanager.dev' }
  let!(:user) { create(:user) }
  let(:headers) {
    {
      'Content-Type' => Mime[:json].to_s,
      'Accept' => 'application/vnd.taskmanager.v1',
      'Authorization' => user.auth_token
    }
  }

  describe 'GET /tasks' do
    before do
      create_list(:task, 5, user_id: user.id)
      get '/tasks', params: {}, headers: headers
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns 5 tasks from database' do
      expect(json_body[:tasks].count).to eq(5)
    end
  end

  describe 'GET /tasks/:id' do
    let(:task) { create(:task, user_id: user.id) }
    before { get "/tasks/#{task.id}", params: {}, headers: headers }

    it 'returns status code' do
      expect(response).to have_http_status(200)
    end

    it 'returns the json for task' do
      expect(json_body[:title]).to eq(task.title)
    end
  end
end
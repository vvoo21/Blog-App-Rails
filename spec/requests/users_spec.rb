require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { User.create(name: 'vanessa', photo: 'https://pixabay.com/photos/cat-baby-profile-animal-shelter-2671159/', bio: 'A passionate full-stack developer', posts_count: 0) }

  describe 'GET /index' do
    it 'returns http success' do
      get users_path
      expect(response.status).to eq(200)
    end

    it 'correct template is rendered' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'response body includes correct placeholder text' do
      get users_path
      expect(response.body).to include(user.name)
    end
  end

  describe 'GET /show' do
    it 'response status is success' do
      get user_path(user.id)
      expect(response.status).to eq(200)
    end

    it 'correct template is rendered' do
      get user_path(user.id)
      expect(response).to render_template(:show)
    end

    it 'response body includes correct placeholder text' do
      get user_path(user.id)
      expect(response.body).to include(user.bio)
    end
  end
end

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { User.create(name: 'Anna', photo: 'https://pixabay.com/photos/cat-baby-profile-animal-shelter-2671159/', bio: 'A passionate full-stack developer', posts_count: 0) }
  describe 'GET /index' do
    it 'response status is success' do
      get user_posts_path(user)
      expect(response.status).to eq(200)
    end

    it 'correct template is rendered' do
      get user_posts_path(user)
      expect(response).to render_template(:index)
    end

    it 'response body includes correct placeholder text' do
      get user_posts_path(user)
      expect(response.body).to include("Posts")
    end
  end

  describe 'GET /show' do
    let!(:post) { Post.create(author: user, title: 'Hello rails', text: 'Rails', comments_count: 0, likes_count: 0) }
    it 'response status is success' do
      get user_post_path(user, post)
      expect(response.status).to eq(200)
    end

    it 'correct template is rendered' do
      get user_post_path(user, post)
      expect(response).to render_template(:show)
    end

    it 'response body includes correct placeholder text' do
      get user_post_path(user, post)
      expect(response.body).to include(post.title)
    end
  end
end

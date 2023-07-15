require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.new(name: 'David', photo: 'photo.png', bio: 'A full-stack developer') }
  let(:post) { Post.new(author: user, title: 'Hello rails', text: 'Rails is great') }

  subject { Like.new(post:, author: user) }

  before { subject.save }

  it 'belongs to an author' do
    expect(subject.author).to eql user
  end

  it 'belongs to a post' do
    expect(subject.post).to eql post
  end

  it 'updates the likes counter for a post' do
    expect(post.likes_count).to eq(1)
  end

  it 'decrease the likes counter for a post' do
    subject.decrease_likes_count
    expect(post.likes_count).to eq(0)
  end
end
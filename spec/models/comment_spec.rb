require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.new(name: 'David', photo: 'photo.png', bio: 'A full-stack developer') }
  let(:post) { Post.new(author: user, title: 'Hello rails', text: 'Rails is great') }

  subject { Comment.new(post:, author: user, text: 'Hi Vanessa!') }

  before { subject.save }

  describe 'validations' do
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text).is_at_least(2) }
    it { should validate_length_of(:text).is_at_most(100) }
  end

  it 'belongs to an author' do
    expect(subject.author).to eql user
  end

  it 'belongs to a post' do
    expect(subject.post).to eql post
  end

  it 'increments the comments_counter of the post' do
    expect(post.comments_count).to eq(1)
  end

  it 'decrements the comments_counter of the post' do
    subject.decrease_comments_count
    expect(post.comments_count).to eq(0)
  end
end
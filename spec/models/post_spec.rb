require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'David', photo: 'photo.png', bio: 'A full-stack developer') }
  let(:subject) { Post.create(author: user, title: 'Hello rails', text: 'Rails is great') }

  before { user.save }

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_least(2) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text).is_at_least(2) }
    it { should validate_length_of(:text).is_at_most(600) }
    it { should validate_numericality_of(:comments_count).is_greater_than_or_equal_to(0).only_integer }
    it { should validate_numericality_of(:likes_count).is_greater_than_or_equal_to(0).only_integer }
  end

  it 'belongs to an author' do
    expect(subject.author).to eql user
  end

  it 'should return 5 recent comments' do
    expect(subject.recent_comments).to eq(subject.comments.last(5))
  end
end

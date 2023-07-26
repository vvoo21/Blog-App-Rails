describe 'user show page', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Will', photo: 'https://picsum.photos/200', bio: 'Bio for user 1', posts_count: 10)
    @post1 = Post.create(title: 'post1', text: 'text1', comments_count: 5, likes_count: 13, author: @user1)
    @post2 = Post.create(title: 'post2', text: 'text2', comments_count: 5, likes_count: 13, author: @user1)
    @post3 = Post.create(title: 'post3', text: 'text3', comments_count: 5, likes_count: 13, author: @user1)
    @post4 = Post.create(title: 'post4', text: 'text4', comments_count: 5, likes_count: 13, author: @user1)
    visit user_path(@user1)
  end

  it "displays the user's profile picture" do
    expect(page).to have_css("img[src*='#{@user1.photo}']")
  end

  it "displays the user's username" do
    expect(page).to have_content(@user1.name)
  end

  it 'displays the number of posts the user has written' do
    expect(page).to have_content(@user1.posts_count)
  end

  it "displays the user's bio" do
    expect(page).to have_content(@user1.bio)
  end

  it "displays the user's first 3 posts" do
    @user1.recent_posts.each do |post|
      expect(page).to have_content(post.id)
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
      expect(page).to have_content(post.comments_count)
      expect(page).to have_content(post.likes_count)
    end
  end

  it "displays a button that lets view all of a user's posts" do
    expect(page).to have_content('See all posts')
  end

  it "is redirected to that post's show page." do
    click_link(@post1.title, href: "/users/#{@user1.id}/posts/#{@post1.id}")
    expect(page).to have_current_path(user_post_path(@post1.author, @post1))
  end

  it "is redirected to the user's post's index page." do
    click_link('See all posts')
    expect(page).to have_current_path(user_posts_path(@user1))
  end
end

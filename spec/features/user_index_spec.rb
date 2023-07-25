describe 'user index page', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Alex', photo: 'https://picsum.photos/200', bio: 'Bio for user 1', posts_count: 6)
    @user2 = User.create(name: 'Hana', photo: 'https://picsum.photos/200', bio: 'Bio for user 2', posts_count: 3)
    @user3 = User.create(name: 'Maru', photo: 'https://picsum.photos/200', bio: 'Bio for user 3', posts_count: 4)
  end

  it 'displays usernames of each user' do
    visit users_path
    User.all.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'displays profile picture of each user' do
    visit users_path
    User.all.each do |user|
      expect(page).to have_css("img[src*='#{user.photo}']")
    end
  end

  it 'displays the number of posts each user has written' do
    visit users_path
    User.all.each do |user|
      expect(page).to have_content(user.posts_count)
    end
  end

  it "is redirected to that user's show page." do
    visit users_path
    click_link(@user1.name, href: "/users/#{@user1.id}")
    expect(page).to have_current_path(user_path(@user1.id))
  end
end

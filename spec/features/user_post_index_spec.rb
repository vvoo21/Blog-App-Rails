describe "user post index page", type: :feature do
   before(:each) do
     @user1 = User.create(name: 'Will', photo: 'https://picsum.photos/200', bio: 'Bio for user 1', posts_count: 10)
     @post1 = Post.create(title: 'post1', text: 'text1', comments_count: 1, likes_count: 1, author: @user1)
     @post2 = Post.create(title: 'post2', text: 'text2', comments_count: 2, likes_count: 2, author: @user1)
     @post3 = Post.create(title: 'post3', text: 'text3', comments_count: 3, likes_count: 3, author: @user1)
     @post4 = Post.create(title: 'post4', text: 'text4', comments_count: 4, likes_count: 4, author: @user1)
     @comment1 = Comment.create(text: 'Great post', author: @user1, post: @post1)
     Like.create(author: @user1, post: @post1)
 
     visit user_post_path(@user1, @post1)
   end
 
   it "displays a post's title" do
     expect(page).to have_content(@post1.title)
   end
   
   it "displays who wrote the post" do
     expect(page).to have_content(@user1.name)
   end
 
   it "displays how many comments a post has." do
     expect(page).to have_content(@post1.comments_count)
   end
 
   it "displays how many likes a post has." do
     expect(page).to have_content(@post1.likes_count)
   end
 
   it "displays the post's body" do
     expect(page).to have_content(@post1.text)
   end
   
   it 'displays the user name of each commentor' do
     expect(page).to have_content('Will')
   end
 
   it 'displays the comment each commentor left.' do
     expect(page).to have_content(@comment1.text)
   end
 end
RSpec.describe PostService do
    describe '.user_posts' do
      it 'returns posts of a user' do
        user = create(:user)
        create_list(:post, 5, user: user)
  
        posts = PostService.user_posts(user.id.to_s)
  
        expect(posts).to eq(user.posts)
      end
  
      
  end
  
RSpec.describe PostService do
    describe '.user_posts' do
      it 'returns posts of a user' do
        user = create(:user)
        create_list(:post, 5, user: user)
  
        posts = PostService.user_posts(user.id.to_s)
  
        expect(posts).to eq(user.posts)
      end
  
      it 'returns an empty array if user has no posts' do
        user = create(:user)
  
        posts = PostService.user_posts(user.id.to_s)
  
        expect(posts).to be_empty
      end
    end
  
    describe '.post_params' do
        it 'returns parameters for a post' do
          params = PostService.post_params('Title', 10.5, 'uri')
    
          expect(params).to eq({ title: 'Title', image: 'uri', price: 10.5 })
        end
    
        it 'returns parameters without price if price is nil' do
          params = PostService.post_params('Title', nil, 'uri')
    
          expect(params).to eq({ title: 'Title', image: 'uri' })
        end
      end
    
      describe '.parse_filename' do
        it 'returns a filename based on user name and content type' do
          filename = PostService.parse_filename('username', 'image/jpeg')
    
          expect(filename).to start_with('username/')
          expect(filename).to include('.')
        end
      end    
      
  end
  
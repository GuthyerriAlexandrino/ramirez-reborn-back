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

      describe '.get_post' do
        it 'returns the requested post of an author' do
          author = create(:user)
          post = create(:post, user: author)
    
          retrieved_post = PostService.get_post(author.id.to_s, post.id.to_s)
    
          expect(retrieved_post).to eq(post)
        end
    
        it 'raises an error if the author is invalid' do
            invalid_author_id = 'invalid_author_id'
            post_id = 'post_id'
      
            expect {
              PostService.get_post(invalid_author_id, post_id)
            }.to raise_error(UserService::InvalidUserException, 'Invalid post author')
          end
      
          it 'returns nil if the post does not belong to the author' do
            author = create(:user)
            another_user = create(:user)
            post = create(:post, user: another_user)
      
            retrieved_post = PostService.get_post(author.id.to_s, post.id.to_s)
      
            expect(retrieved_post).to be_nil
          end
        end
  end
  
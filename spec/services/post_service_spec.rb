require 'rails_helper'

RSpec.describe PostService do
    describe '.user_posts' do
      it 'returns posts of a user' do
        user = instance_double(User, id: '123', posts: [Post.new, Post.new])
        allow(User).to receive(:find).with({ _id: user.id }).and_return(user)

        posts = described_class.user_posts(user.id.to_s)

        expect(posts).to eq(user.posts)
      end

      it 'returns an empty array if user has no posts' do
        user = instance_double(User, id: '123', posts: [])
        allow(User).to receive(:find).with({ _id: user.id }).and_return(user)

        posts = described_class.user_posts(user.id.to_s)

        expect(posts).to be_empty
      end
    end

    describe '.post_params' do
        it 'returns parameters for a post' do
          params = described_class.post_params('Title', 10.5, 'uri')

          expect(params).to eq({ title: 'Title', image: 'uri', price: 10.5 })
        end

        it 'returns parameters without price if price is nil' do
          params = described_class.post_params('Title', nil, 'uri')

          expect(params).to eq({ title: 'Title', image: 'uri' })
        end
      end

      describe '.parse_filename' do
        it 'returns a filename based on user name and content type' do
          filename = described_class.parse_filename('username', 'image/jpeg')

          expect(filename).to start_with('username/')
          expect(filename).to include('.')
        end
      end

      describe '.get_post' do
        it 'returns the requested post of an author' do
          post = instance_double(Post, id: '1')
          author = instance_double(User, id: '123', posts: [post])

          allow(author.posts).to receive(:detect).and_return(post)
          allow(User).to receive(:where).with('posts._id' => post.id).and_return(User)
          allow(User).to receive(:first).and_return(author)
          allow(BSON::ObjectId).to receive(:from_string).and_return(post.id)

          retrieved_post = described_class.get_post(post.id.to_s)

          expect(retrieved_post).to eq(post)
        end
      end
  end

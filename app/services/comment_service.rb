# frozen_string_literal: true

# This module encapsulates comment-related functionality
module CommentService
  # Returns the specified comment under the specified post
  # @param comment_id [String]
  # @param post [Post]
  # @return [Comment]
  def self.get_comment(comment_id, post)
    comment = post.comments&.find(comment_id)
    raise InvalidCommentException.new, "This comment don't exists in the specified post" if comment.nil?

    comment
  end

  class InvalidCommentException < StandardError; end
end

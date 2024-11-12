# frozen_string_literal: true

module Posts
  class Create
    include Interactor

    def call
      post = Post.new(context.params)
      post.user = context.current_user
      context.post = post
      context.fail! unless post.save
    end
  end
end

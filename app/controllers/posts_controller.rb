class PostsController < ApplicationController
  def index
    @posts = if current_user&.active?
              Post.all
              else
                Post.where(premium: false)
              end
  end

  def show
    @post = Post.find(params[:id])
    if @post.premium? && !current_user.active?
      redirect_to posts_path, alert: "Post for premium subscribers"
    end
  end
end

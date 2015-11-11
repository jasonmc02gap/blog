include PotatoConfiguration

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :fetch_featured


  def fetch_featured
    posts = db.view(Post.all)

    comments_count = []
    posts.each do |post|
      comments_count.push({:post => post, :comments => db.view(Comment.post_comments(:key => post.id)).size})
    end

    comments_count.sort_by {|field| field[:comments] }

    @featured_post = comments_count.first[:post]
  end
end

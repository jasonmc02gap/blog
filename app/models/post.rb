class Post
  include CouchPotato::Persistence

  property :title, type: String
  property :content, type: String
  property :user_id, type: String
  property :comment_ids, type: Array
  
  view :all, :key => :_id, :properties => [:_id, :_rev, :created_at, :updated_at, :title, :content, :user_id, :comment_ids], :type => :properties

  def comments
    db.view Comment.post_comments(key: self.id)
  end

  private

end

class Comment
  include CouchPotato::Persistence
  include PotatoConfiguration
  
  property :body, type: String
  property :user_id, type: String
  property :post_id, type: String
   
  view :all, :key => :_id, :properties => [:_id, :_rev, :created_at, :updated_at, :body, :user_id, :post_id], :type => :properties
  view :post_comments, :key => :post_id, :properties => [:_id, :_rev, :created_at, :updated_at, :body, :user_id], :type => :properties
  before_save :add_user_id, :add_post_id

  private
  def add_user_id
    users = db.view User.all
    if users.blank?
      user = User.new(:first_name => "Test", :last_name => "Test", :email => "test_email")
      user.save
      self.user_id = user.id
    else
      self.user_id = users.first.id
    end
  end

  def add_post_id
    posts = db.view Post.all
    if posts.blank?
      post = Post.new(:title => "Test", :content => "Test")
      post.save
      self.post_id = post.id
    else
      self.post_id = posts.first.id
    end
  end
end

class Post
  include CouchPotato::Persistence

  property :title, type: String
  property :content, type: String
  property :user_id, type: String
  property :comment_ids, type: Array
  
  view :all, :key => :_id, :properties => [:_id, :_rev, :created_at, :updated_at, :title, :content, :user_id, :comment_ids], :type => :properties

  before_save :add_user_id

  def user
    db.load self.user_id
  end

  def add_user_id
    users = db.view User.all
    unless users
      user = User.new(:first_name => "Test", :last_name => "Test", :email => "test_email")
      user.save
      self.user_id = user.id
    else
      self.user_id = users.first.id
    end
  end
end

class Post
  include CouchPotato::Persistence

  property :title, type: String
  property :content, type: String
  property :user_id, type: String
  property :comment_ids, type: Array
  
  view :all, :key => :_id, :properties => [:_id, :_rev, :created_at, :updated_at], :type => :properties

end

class Comment
  include CouchPotato::Persistence

  property :body, type: String
  property :user_id, type: String
  property :post_id, type: String

  view :all, :key => :_id, :properties => [:_id, :_rev, :created_at, :updated_at], :type => :properties

end

class Comment
  
  include CouchPotato::Persistence
  include PotatoConfiguration
  include ActiveModel::Validations
  property :body, type: String
  property :user_id, type: String
  property :post_id, type: String
   
  view :all, :key => :_id, :properties => [:_id, :_rev, :created_at, :updated_at, :body, :user_id, :post_id], :type => :properties
  view :post_comments, :key => :post_id, :properties => [:_id, :_rev, :created_at, :updated_at, :body, :user_id, :post_id], :type => :properties
  view :user_comments, :key => :user_id, :properties => [:_id, :_rev, :created_at, :updated_at, :body, :user_id, :post_id], :type => :properties
  
  validates :body , presence: true

end

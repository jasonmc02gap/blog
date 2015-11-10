class User
  include CouchPotato::Persistence
  
  property :first_name, type: String
  property :last_name, type: String
  property :email, type: String
  property :post_ids, type: Array
  property :comment_ids, type: Array

  view :all, :key => :_id, :properties => [:_id, :_rev, :created_at, :updated_at], :type => :properties

end

class Comment
  
  include CouchPotato::Persistence
  include PotatoConfiguration
  
  property :body, type: String
  property :user_id, type: String
  property :post_id, type: String
   
  view :all, :key => :_id, :properties => [:_id, :_rev, :created_at, :updated_at, :body, :user_id, :post_id], :type => :properties
  view :post_comments, :key => :post_id, :properties => [:_id, :_rev, :created_at, :updated_at, :body, :user_id, :post_id], :type => :properties
  view :user_comments, :key => :user_id, :properties => [:_id, :_rev, :created_at, :updated_at, :body, :user_id, :post_id], :type => :properties
 
  validate :not_empty_fields

  private

  def not_empty_fields
    body.blank? || user_id.blank? || post_id.blank? ? errors.add(:base,"Fields can't be blank") : true
  end
end

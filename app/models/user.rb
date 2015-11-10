class User
  include CouchPotato::Persistence
  include PotatoConfiguration
  
  property :first_name, type: String
  property :last_name, type: String
  property :email, type: String
  property :password, type: String
  property :post_ids, type: Array
  property :comment_ids, type: Array

  view :all, :key => :_id, :properties => [:_id, :_rev, :created_at, :updated_at], :type => :properties
  
  def save
    self.db.save_document self  
  end

  def update
    save
  end

  def destroy
    self.db.destroy_document self
  end
end

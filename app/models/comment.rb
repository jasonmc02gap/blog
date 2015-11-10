require '/lib/potato_configuration'
class Comment
  include CouchPotato::Persistence
  include PotatoConfiguration

  property :body, type: String
  property :user_id, type: String
  property :post_id, type: String

  view :all, :key => :_id, :properties => [:_id, :_rev, :created_at, :updated_at], :type => :properties

  def save
    database.save_document self  
  end

  def update
    save
  end

  def destroy
    database.destroy_document self
  end
end

module PotatoConfiguration
  def db
  	return CouchPotato.database
  end 

  def create_database
  	CouchPotato.couchrest_database_for_name!("blog_develop") #needs to be changed
  end

  def save
    self.db.save_document self  
  end

  def destroy
    self.db.destroy_document self
  end

  def user
    db.load self.user_id
  end

  def post
    db.load self.post_id
  end
end
module PotatoConfiguration
  def db
  	return CouchPotato.database
  end 

  def create_database
  	CouchPotato.couchrest_database_for_name!("blog_develop") #needs to be changed
  end
end
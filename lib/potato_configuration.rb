module PotatoConfiguration
  def database
  	CouchPotato.database
  end 

  def create_database
  	CouchPotato.couchrest_database_for_name!("blog_develop") #needs to be changed
  end
end
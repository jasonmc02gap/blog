class Post
  include CouchPotato::Persistence
  
  view :all, :key => :_id, :properties => [:_id, :_rev, :created_at, :updated_at], :type => :properties

  list :json_array, <<-JS
    function (head, req) {
      var row, objects = [];
      while (row = getRow()) {
        objects.push(JSON.stringify(row.value));
      };
      send("[" + objects.join(",") + "]");
    }
  JS
end

class Comment
  include CouchPotato::Persistence

  property :body, type: String
  property :user_id, type: String
  property :post_id, type: String

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

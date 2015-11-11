$("#comments").empty();
$("#comments").append("<%= escape_javascript(render partial: 'comments', locals: { post: @post })%>");
$("#comment_body").val("");
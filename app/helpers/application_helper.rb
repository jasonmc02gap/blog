module ApplicationHelper

  def comments_counter(comments_length)
    case comments_length
    when 0
      return "No comments yet"
    when 1
      return "One comment"
    else
      return "#{comments_length} comments"
    end
  end

  def profile_image(user_id)
    user = db.load(user_id)

    if user._attachments.blank?
      return "http://placehold.it/80x80&text=[img]"
    else
      db.database_path + "/#{user_id}/profile"
    end
  end
end

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
end

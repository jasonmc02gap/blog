class Post

  include CouchPotato::Persistence

  property :title, type: String
  property :content, type: String
  property :user_id, type: String
  property :slug, type: String

  attr_accessor :image
  
  view :all, :key => :_id, :properties => [:_id, :_rev, :_attachments, :created_at, :updated_at, :title, :content, :user_id, :comment_ids, :slug], :type => :properties
  view :user_posts, :key => :user_id, :properties => [:_id, :_rev, :_attachments, :created_at, :updated_at, :title, :content, :user_id, :comment_ids, :slug], :type => :properties
  view :by_slug, :key => :slug, :properties => [:_id, :_rev, :_attachments, :created_at, :updated_at, :title, :content, :user_id, :comment_ids, :slug], :type => :properties
  
  before_save :generate_slug

  validate :not_empty_fields

  def to_param
    slug
  end
  
  def comments
    db.view Comment.post_comments(key: self.id)
  end

  def generate_slug
    self.slug = self.title.to_s.downcase.gsub(/[^a-z1-9]+/, '-')
  end

  private

  def not_empty_fields
    title.blank? || content.blank? || user_id.blank? ? errors.add(:base,"Fields can't be blank") : true
  end
end

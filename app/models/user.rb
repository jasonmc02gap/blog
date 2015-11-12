class User

  include CouchPotato::Persistence
  include PotatoConfiguration
  property :first_name, type: String
  property :last_name, type: String
  property :email, type: String
  property :password_hash, type: String
  property :password_salt, type: String
  property :slug, type: String

  attr_accessor :password
  attr_accessor :image

  view :all, :key => :_id, :properties => [:_id, :_rev, :created_at, :updated_at, :first_name, :last_name, :email, :password_salt, :password_hash, :slug], :type => :properties
  view :by_email, :key => :email, :properties => [:_id, :_rev, :created_at, :updated_at, :first_name, :last_name, :email, :password_salt, :password_hash, :slug], :type => :properties
  view :by_slug, :key => :slug, :properties => [:_id, :_rev, :created_at, :updated_at, :first_name, :last_name, :email, :password_salt, :password_hash, :slug], :type => :properties

  before_save :encrypt_password, :generate_slug

  validates_confirmation_of :password
  validates :password, :first_name, :last_name, :email, presence: true, on: :create
  validate :uniqueness_of_email, :not_empty_fields
  
  def to_param
    slug
  end

  def self.authenticate(email,password)
    user = db.view User.by_email(key: email)
    if user && password_match(password,user.first)
      user.first
    else
      nil
    end
  end

  def self.password_match(password,user)
    user.password_hash == BCrypt::Engine.hash_secret(password,user.password_salt)
  end

  def generate_slug
    self.slug = "#{self.first_name} #{self.last_name}".to_s.downcase.gsub(/[^a-z1-9]+/, '-')
  end

  private

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
    end
  end

  def uniqueness_of_email
    db.view(User.by_email(key: email)).blank? ? true : errors.add(:email,"is already taken")
  end

  def not_empty_fields
    first_name.blank? || last_name.blank? || email.blank? || password.blank? || password_confirmation.blank? ? errors.add(:base,"Fields can't be blank") : true
  end
end

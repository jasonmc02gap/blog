class User
  include CouchPotato::Persistence
  include PotatoConfiguration
  attr_accessor :password
  validates_confirmation_of :password
  validates :password, :first_name, :last_name, :email, presence: true, on: :create
  property :first_name, type: String
  property :last_name, type: String
  property :email, type: String
  property :password_hash, type: String
  property :password_salt, type: String
  property :post_ids, type: Array
  property :comment_ids, type: Array

  view :all, :key => :_id, :properties => [:_id, :_rev, :created_at, :updated_at, :first_name, :last_name, :email, :password_salt, :password_hash], :type => :properties
  view :by_email, :key => :email, :properties => [:_id, :_rev, :created_at, :updated_at, :first_name, :last_name, :email, :password_salt, :password_hash], :type => :properties
  before_save :encrypt_password
  validate :uniqueness_of_email
  

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
  private

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password,password_salt)
    end
  end

  def uniqueness_of_email
    true
  end
end

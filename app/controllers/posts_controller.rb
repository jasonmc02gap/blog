include PotatoConfiguration

class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, :except => [:index, :show]

  def index
    @posts = db.view Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    @post._attachments = construct_attach
    @post.user_id = session[:user_id]

    respond_to do |format|
      @post.save ? format.html { redirect_to @post, notice: 'Post was successfully created.' } : format.html { render :new }
    end
  end

  def update
    respond_to do |format|
      @post.title = post_params[:title]
      @post.content = post_params[:content]
      @post.save ? format.html { redirect_to @post, notice: 'Post was successfully updated.' } : format.html { render :edit }
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private
    def set_post
      @post = db.load params[:id]
    end

    def post_params
      params.require(:post).permit(:title, :content, :image)
    end

    def attach_image
      File.read(post_params[:image].tempfile)
    end

    def construct_attach
      {"post_image" => {
        'data' => attach_image, 
        'content_type' => post_params[:image].content_type
        }
      }
    end
end

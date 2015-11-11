include PotatoConfiguration
class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = db.view Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = session[:user_id]

    respond_to do |format|
      if @comment.save
        @post = db.load @comment.post_id
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      @comment.body = comment_params[:body]
      
      @comment.save ? format.html { redirect_to @comment, notice: 'Comment was successfully updated.' } : format.html { render :edit }
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
    end
  end

  private
    def set_comment
      @comment = db.load params[:id]
    end

    def comment_params
      params.require(:comment).permit(:user_id,:post_id,:body)
    end
end

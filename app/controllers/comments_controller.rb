class CommentsController < ApplicationController

  before_action :set_comment, only: [:show]

  def show
    @title = "Comment/Show - #{@comment.id}"
  end

  def new
    @title = "Comment/New"

    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.commentable, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment.commentable }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content, :commentable_id, :commentable_type).merge(user_id: current_user.id)
    end
end

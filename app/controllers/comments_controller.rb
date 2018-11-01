class CommentsController < ApplicationController

  before_filter :admin_auth, :except => [:create, :show, :destroy]

  def edit
    @comment = Comment.find(params[:id])
  end

  def create
    @comment = Comment.new(params[:comment])
    @comment.post_id = params[:post_id]
    @comment.user_id = current_user.id if user_signed_in?

    respond_to do |format|
      if @comment.save
        CommentNotifier.created(@comment).deliver
        format.html { redirect_to post_path(@comment.post_id), notice: 'Comment was successfully created.' }
        format.js
      else
        format.html { redirect_to :back, alert: 'Comment could not be posted.' }
        format.js { render 'error' } 
      end
    end
  end
  
  #only for deleting
  def show
    @comment = Comment.find(params[:id])
    @deletion_auth = deletion_auth
    flash[:d] = params[:d]
    
    respond_to do |format|
      format.html { render action: "show" }
    end
  end

  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        CommentNotifier.created(@comment).deliver
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    post_id = @comment.post_id

    note = "You are not authorized to delete the comment."     
    if deletion_auth  # Check 
      @comment.destroy
      note = 'Comment was successfully deleted.'
      note.concat(' Method: remote') if params[:d]
    end
    
    respond_to do |format|
      format.html { redirect_to post_path(post_id), notice: note }
    end
  end
  
private  

  def deletion_auth
    admin? || flash[:d] == @comment.token || params[:d] == @comment.token
  end
end

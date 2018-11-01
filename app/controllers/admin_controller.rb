class AdminController < ApplicationController
  before_filter :admin_auth
  
  def index    
  end
  
  def publish
    @post = Post.find(params[:id])
    @post.published = true
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_path, notice: 'Post was successfully published.' }
      else
        format.html { redirect_to admin_path, alert: 'Post could not be published.' }
      end
    end  
  end
end

class HomeController < ApplicationController
	def index
    @posts = Post.pub.recent  # Recently published posts

    respond_to do |format|
      format.html
    end	  
	end
end

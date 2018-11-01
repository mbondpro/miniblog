class PostsController < ApplicationController
  
  before_filter :admin_auth, :except => [:index, :show]

  def index
    if params[:category_id]
      @category = Category.find(params[:category_id]) 
      @posts = @category.posts.pub.paginate(:page => params[:page])      
      @page_title = @category
    else
      @posts = Post.pub.paginate(:page => params[:page])
      @page_title = 'All Posts'
    end

    respond_to do |format|
      format.html 
    end
  end

  def show
    @bad_comment = flash[:bad_comment] #workaround for flash not showing
    @post = Post.find(params[:id])    
    
    if @bad_comment
    	@comment = @bad_comment
   	else  	
	    @comment = Comment.new
	  end
    @comments = @post.comments
    
    # Shows Amazon products, given a valid Amazon Products API key in config
    # Remove comments to enable.
    #s = Search.new(@post.terms)  #search on title if no terms
    #@items = s.items.first(3)
    #@result = s.result

    @items = {}  # Comment out this line after providing your Amazon info.
    

    respond_to do |format|
      if @post.published? || current_user.try(:admin?)
        format.html
      else
        format.html { redirect_to posts_path, alert: 'That post is not available.' }
      end
    end
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html 
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_path, notice: 'Post was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
    end
  end
end

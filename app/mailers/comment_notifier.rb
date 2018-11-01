class CommentNotifier < ActionMailer::Base
  default from: <your email>
  default to: <your email>

  def created(comment)
    @comment = comment 
    @post = Post.find(@comment.post_id)
    @link = url_for(@post)
    @deletion = url_for(:controller => :comments, :action => :show, :id => @comment.id) + "?d=#{@comment.token}"
    mail subject: "Blog comment posted" 
  end

end

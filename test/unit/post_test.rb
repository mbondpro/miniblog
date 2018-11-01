require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  fixtures :posts
  attr_accessor :post
  
  def setup
    @post = posts(:one)
  end
  
  test "invalid when empty" do
    post = Post.new
    assert !post.save
  end
  
  test "invalid title when empty" do
    post = Post.new
    post.body = "hey"
    assert !post.save
  end
  
  test "invalid body when empty" do
    @post.body = ""
    assert !@post.save
  end 
  
  test "invalid category when empty" do
    @post.category = nil
    assert !@post.save
  end   
  
  test "catches title too long" do
    pp @post
    puts "valid? " + @post.valid?.to_s
    @post.title = "xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx "
    puts "valid? " + @post.valid?.to_s
    @post.title = "xxxxxxxxx xx"
    puts "valid? " + @post.valid?.to_s
    assert !@post.save
  end   
  
  test "catches subtitle too long" do
    @post.subtitle = "xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx "
    assert !@post.save
  end   
  
  test "catches duplicate title" do
    @post.title = "My Title 2"
    assert !@post.save
  end
    
end

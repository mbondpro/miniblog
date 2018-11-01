require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  fixtures :categories
  
  def setup
    @cat = categories(:one)
  end
    
  test "invalid when empty" do
    cat = Category.new
    assert !cat.valid?
  end
  
  test "catches title too long" do
    @cat.title = "xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx xxxxxxxxx "
    assert !@cat.valid?
  end   
  
  test "catches duplicate title" do
    @cat.title = "Category Two"
    assert !@cat.valid?
  end  
  
end

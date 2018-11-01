class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  
  attr_accessible :name, :body, :post_id
  
  before_create :make_token
  
  default_scope :order => 'updated_at desc'
  
  validates_presence_of :post_id, :body, :name
  validates_length_of :body, :maximum => 2500
  
  def to_s
    self.body
  end  
  
  def updated
    self.updated_at.strftime("%b %d, %Y")  
  end
  
  def display_name
    if self.user.nil?
      name
    else      
      self.user.username
    end
  end
  
  private
  
  def make_token
    self.token = rand(36**16).to_s(36) 
  end
  
end

class Category < ActiveRecord::Base
  has_many :posts
  
  def to_s
    self.title
  end
  
  # SEO-friendly URI
  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end

  validates_presence_of :title
  validates_length_of :title, :within => 3..30
  validates_uniqueness_of :title
  
end

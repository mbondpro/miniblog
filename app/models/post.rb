class Post < ActiveRecord::Base
  belongs_to :category
  has_many :comments
  before_validation :rich_text
  
  self.per_page = 10
    
  default_scope :order => 'updated_at desc'  # Order by most recent dates
  scope :pub, where(:published => true) # Only published posts
  scope :unpub, where(:published => false) # Only unpublished posts
  scope :recent, limit(10) # Recent posts

  def to_s
    self.title
  end
  
  # SEO-oriented URLs
  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end
  
  # Search terms to be used with Amazon Products API to display related products
  def terms
    return self.keywords unless self.keywords.blank?
    "search #{self.title}"
  end  
  
  def cat_title
    self.category.title unless self.category.blank?
  end

  validates_presence_of :title, :category
  validates_length_of :title, :within => 3..50
  validates_uniqueness_of :title
  
  private
  
  # 'Rich text' codes to replace before saving. These allow posters
  # To use codes instead of HTML tags to stylize text in the body.
  # Use ///text\\\ for italics, [[[text]]] for bold
  def rich_text
    [ [/\[\[\[/, '<b>'], 
      [/\]\]\]/, '</b>'],
      [/\/\/\//, '<i>'],
      [/\\\\\\/, '</i>']     
    ].each do |rule|
      self.body = self.body.gsub(rule[0], rule[1])
    end
  end
      
end

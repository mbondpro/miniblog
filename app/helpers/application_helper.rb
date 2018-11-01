module ApplicationHelper

  def page_title_raw
    @page_title ? "#{@page_title} | " : ''
  end  

  # Compiles custom page title with an addition to the title that persist on all pages
  # e.g., "Tech Posts | My Blog"
  def page_title        
    %(<title>#{page_title_raw}My Blog</title>)  # Customize this for your blog
  end
  
  def meta(name, content)
    %(<meta name="#{name}" content="#{content}" />)
  end  

  # Customize meta tags according to page content, for SEO
  def meta_description
    description = ["Description here."]  # Change this for your site
    description << @category.title if @category
    description << [@post.title, @post.cat_title ] if @post
    description.join(". ")
  end

  # Customize meta tags according to page content, for SEO
  # Update for your own 
  def meta_keywords
    keywords = []  # keywords = ["one, two, three"]
    if @category and !@category.new_record?
      keywords << [@category.title]
    end
    if @post and !@post.new_record?
      keywords << [@post.title, @post.subtitle]
    end
    keywords.join(",")
  end
  
  def admin?
    current_user.try(:admin?)
  end
end

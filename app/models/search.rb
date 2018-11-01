class Search
	
  # Searches for products in Amazon Product API.
  # Uses Amazon_product gem to wrap requests

	attr_accessor :term, :req, :result, :items
	
	def initialize(srch)
		req = AmazonProduct["us"]
		req.configure do |c|
      c.key    = ''  # Yours here
      c.secret = ''  # Yours here
      c.tag    = ''  # Yours here
    end
    
    # If user puts "search" in the search terms, it will treat tokens as search terms
    # Otherwise, it treats tokens as ASINs
    if srch.include? "search"
      srch.gsub! "search ", ""  # Remove 'search' indicator
      @result = req.search("All", :keywords => srch, :response_group => 'Small, OfferSummary, Images')
    else  # ASINs
	    @result = req.find(srch, :response_group => 'Small, OfferSummary, Images')
	  end	
		@items = []
    @result['Item'].each {|item| @items.push(Item.new(item)) }  # Array for the view
    
    puts @result.errors    
	end
	
end

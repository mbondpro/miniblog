class Item

  # Amazon Products API functions. Allows keywords related to a post to be sent to
  # Amazon and return a list of related products
  # Uses Amazon_product gem to wrap requests

	attr_accessor :asin, :title, :author, :price, :image, :url
	
	def initialize(item_hash)
		parse(item_hash)
	end
  	
	private
	
	# build the Item instance from a hash of the result
	def parse(item)	
		@asin = item['ASIN']
		@title = item['ItemAttributes']['Title'] if item['ItemAttributes']
		if item['ItemAttributes']
		  @author = item['ItemAttributes']['Author'].to_s.gsub(/\"/, '').gsub(/[\[\]]/, '')
		end 
		@image = item['SmallImage']['URL'] if item['SmallImage']
		@url = item['DetailPageURL']
    @price = get_price(item)
	end	
	
	def get_price(item)
    pr = item['OfferSummary']['LowestNewPrice']['Amount'] 
    if pr #verify what AMZ returns when no new price available
      item['OfferSummary']['LowestNewPrice']['FormattedPrice']
    else
      item['OfferSummary']['LowestUsedPrice']['FormattedPrice']
    end   	
    
    rescue Exception
      return "No price available" 
	end
	
end

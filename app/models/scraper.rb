class Scraper
	#  in order to access attribute from movie model, this is needed
	attr_accessor :title, :hotness, :image_url, :synopsis, :rating, :genre, :director, :release_date, :runtime, :failure

	def scrape_new_movie(url)
		begin
			doc = Nokogiri::HTML(open(url))
			doc.css('script').remove 
			self.title = doc.at("//h1[@itemprop = 'name']").text  
			self.hotness = doc.at("//span[@itemprop = 'ratingValue']").text.to_i 
			self.image_url = doc.at_css('#movie-image-section img')['src'] 
			self.rating = doc.at("//td[@itemprop = 'contentRating']").text 
			self.director = doc.at("//td[@itemprop = 'director']").css('a').first.text 
			self.genre = doc.at("//span[@itemprop = 'genre']").text 
			#  no more date field in rotten tomatoes website
			self.release_date = ("Oct 2,2015").to_date 	
			self.runtime = doc.at("//time[@itemprop = 'duration']").text 
			self.synopsis = doc.css('#movieSynopsis').text.tidy_bytes
			
			return true
		rescue Exception => e
		self.failure = e
		end
	end

	
end
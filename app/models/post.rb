class Post < ActiveRecord::Base
	include PgSearch
	@@default_title = "Post title"
	@@default_body = "Post body"

	has_one :location

	#may need a "content searchable" here
	pg_search_scope :search, 
    :against => {  
    :title => 'A',
    :content_html => 'C'    
   },       
    :associated_against => {
    :tags => [:name],   
    :category => [:name] 
   }



	default_scope { order("created_at DESC") }

	self.per_page = 10

	acts_as_url :title

	acts_as_ordered_taggable_on :tags, :category

	TAG_REGEX = /^(\w| )+$/ #letters, numbers underscores or spaces, but nothing else. also =~ is regex match, ^ is start of string, $ is end of string, and the + is one or more matches

	def to_param
		url #this just uses stringex/acts_as_url's url for its param
	end

	def disqus_id
		url+id.to_s
	end

	def set_defaults
		self.title = @@default_title
		self.content_markdown = @@default_body
	end

	def category
		category_list.first
	end

	def new_mail(request)
	    Subscription.where(active: true).each do |subscription|
	    	#Mailer.new_post(self, subscription, request.host, request.port).deliver
	    	Mailer.delay.new_post(self, subscription, request.host, request.port)
	    end
	end

	def shortened_content_html
		Truncato.truncate content_html, max_length: 250
	end


	#validates :category_list, length: { minimum:1, maximum:1 } #I don't even think this works; it's checking characters, not list length (though perhaps it would learn better later?)
	#TODO: WHEN WE DO THIS, GO INTO THE CONTROLLER AND ADD CATEGORIES TO POST PARAMETERS OR ELSE  IT WON'T WORKY GUD

	validates :title, presence: true,
	uniqueness: { case_sensitive: false },
	length: { maximum: 100 }

	validates :content_markdown, presence: true
	validates :content_html, presence: true

	validate :no_default_values

	validate :tags_and_categories

	private

		def tags_and_categories
	    	for tag in tag_list
	     	  errors.add(:tag_list, "- a tag is too long (maximum is 50 characters)") if tag.length > 50 
	     	  errors.add(:tag_list, "- a tag is contains invalid characters") unless tag =~ TAG_REGEX 
	    	end
	    	errors.add(:category_list, "- must have exactly one category") if category_list.length != 1
	    	for category in category_list
	     	  errors.add(:category_list, "- a category is too long (maximum is 50 characters)") if category.length > 50  
	     	  errors.add(:category_list, "- a category is contains invalid characters") unless category =~ TAG_REGEX
	    	end

	 	end

		def no_default_values
			errors.add(:title, '- has default value') if self.title == @@default_title
			errors.add(:content_markdown, '- has default value') if self.content_markdown == @@default_body
		end
end

class Post < ActiveRecord::Base
	@@default_title = "Post title"
	@@default_body = "Post body"

	self.per_page = 10

	acts_as_url :title

	acts_as_taggable_on :tags, :category

	def to_param
		url #this just uses stringex/acts_as_url's url for its param
	end

	def set_defaults
		self.title = @@default_title
		self.content_markdown = @@default_body
	end


	validate :tags_and_categories

	#validates :category_list, length: { minimum:1, maximum:1 } #I don't even think this works; it's checking characters, not list length (though perhaps it would learn better later?)
	#TODO: WHEN WE DO THIS, GO INTO THE CONTROLLER AND ADD CATEGORIES TO POST PARAMETERS OR ELSE  IT WON'T WORKY GUD

	validates :title, presence: true,
	uniqueness: { case_sensitive: false },
	length: { maximum: 100 }

	validates :content_markdown, presence: true
	validates :content_html, presence: true

	validate :no_default_values

	private
		def tags_and_categories
	    	for tag in tag_list
	     	  errors.add(:tag, "too long (maximum is 50 characters)") if tag.length > 50  
	    	end
	    	errors.add(:base, "Must have exactly one category") if category_list.length != 1
	    	for category in category_list
	     	  errors.add(:categry, "too long (maximum is 50 characters)") if tag.length > 50  
	    	end

	 	end

		def no_default_values
			errors.add(:title, 'has default value') if self.title == @@default_title
			errors.add(:content_markdown, 'has default value') if self.content_markdown == @@default_body
		end
end

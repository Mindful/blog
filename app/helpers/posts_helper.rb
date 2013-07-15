module PostsHelper

	def post_next_page_path(collection)
		url_for(params.merge(:page => collection.next_page))
	end

	def post_previous_page_path(collection)
		url_for(params.merge(:page => collection.previous_page))
	end

	def category_select_options
		Category.all.map {|category| [category.name.titleize, category.name]}
	end
end

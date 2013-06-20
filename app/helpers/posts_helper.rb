module PostsHelper

	def public_post_path(post)
		'/posts/'+post.url
	end
end

module PostsHelper
	def public_post_path(post)
		'/posts/'+post.id.to_s
	end
end

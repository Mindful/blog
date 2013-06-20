class Post < ActiveRecord::Base
	self.per_page = 10

	acts_as_url :title, :sync_url => true

	validates :title, presence: true,
	uniqueness: { case_sensitive: false },
	length: { maximum: 100 }

	validates :content_markdown, presence: true
	validates :content_html, presence: true

	def to_param
		url
	end
end

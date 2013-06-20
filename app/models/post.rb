class Post < ActiveRecord::Base
	@@default_title = "Post title"
	@@default_body = "Post body"

	self.per_page = 10

	acts_as_url :title, :sync_url => true

	validates :title, presence: true,
	uniqueness: { case_sensitive: false },
	length: { maximum: 100 }

	validates :content_markdown, presence: true
	validates :content_html, presence: true

	validate :no_default_values

	def set_defaults
		self.title = @@default_title
		self.content_markdown = @@default_body
	end

	def no_default_values
		errors.add(:title, 'has default value') if self.title = @@default_title
		errors.add(:content_markdown, 'has default value') if self.content_markdown = @@default_body
	end

	def to_param
		url
	end
end

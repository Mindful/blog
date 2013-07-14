class Category < ActiveRecord::Base
  belongs_to :tag, :class_name => 'ActsAsTaggableOn::Tag'

  #all tags are forced lowercase before saving, so we should search for them by lowercase

  before_validation :associate_tag #before_save is after validation

  validates :title, presence: true,
	uniqueness: { case_sensitive: false },
	length: { maximum: 50 }

  private
  	def associate_tag
  		self.tag = ActsAsTaggableOn::Tag.find_or_create_by(name: name.downcase)
  	end
end

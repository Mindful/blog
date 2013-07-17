class Category < ActiveRecord::Base
  belongs_to :tag, :class_name => 'ActsAsTaggableOn::Tag'

  #all tags are forced lowercase before saving, so we should search for them by lowercase

  before_validation :associate_tag #before_save is after validation

  before_destroy :can_destroy? #if can_destroy? returns false, the model is not destroyed

  validates :name, presence: true,
	uniqueness: { case_sensitive: false },
	length: { maximum: 50 }

  def posts
  	Post.tagged_with(name, :on => :category)
  end

  def can_destroy?
  	posts.length == 0
  end

  def to_param
  	self.name
  end

  private
  	def associate_tag
  		self.tag = ActsAsTaggableOn::Tag.find_or_create_by(name: name.downcase)
  	end
end

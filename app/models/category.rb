class Category < ActiveRecord::Base
  belongs_to :tag, :class_name => 'ActsAsTaggableOn::Tag'
end

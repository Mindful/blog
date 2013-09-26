class Picture < ActiveRecord::Base

  has_attached_file :image, :styles => { :large => "850x850>", :medium => "400x400>", :thumb => "200x200>" }, :default_url => "/images/:style/missing.png"
  
  validates :name, presence:   true,
                    uniqueness: { case_sensitive: false }

  validates_attachment :image, :presence => true,
  :content_type => { :content_type => /^image\/(png|gif|jpeg|jpg|bmp)/ },
  :size => { :in => 0..100.megabytes }

  def url_large
  	self.image.url(:large, timestamp: false)
  end

  def url_medium
  	self.image.url(:medium, timestamp: false)
  end
end

class Picture < ActiveRecord::Base

  has_attached_file :image, :styles => { :large => "700x700>", :medium => "350x350>", :thumb => "150x150>" }, :default_url => "/images/:style/missing.png"
  
  validates :name, presence:   true,
                    uniqueness: { case_sensitive: false }

  validates_attachment :image, :presence => true,
  :content_type => { :content_type => /^image\/(png|gif|jpeg|jpg|bmp)/ },
  :size => { :in => 0..100.megabytes }
end

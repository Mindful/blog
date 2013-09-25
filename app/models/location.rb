class Location < ActiveRecord::Base
	belongs_to :post


	#Image must be 'dot' or 'pushpin'


	def icon
		image+'.png'
	end
end

class NewChallanMailer < ApplicationMailer

	def new_challan_email (citizen,challan)
		@citizen = citizen
		@challan= challan
		mail(to:citizen.email,subject:'New Challan')
	end
end

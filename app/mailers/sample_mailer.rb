class SampleMailer < ApplicationMailer
	def sample_email(citizen)
		@citizen = citizen
		mail(to: @citizen.email,subject:"sample mail")
	end
end

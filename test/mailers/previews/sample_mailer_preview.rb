# Preview all emails at http://localhost:3000/rails/mailers/sample_mailer
class SampleMailerPreview < ActionMailer::Preview

	def sample_mail_preview
   		 SampleMailer.sample_email(Citizen.first)
  	end

end

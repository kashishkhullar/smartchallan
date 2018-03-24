# Preview all emails at http://localhost:3000/rails/mailers/new_challan_mailer
class NewChallanMailerPreview < ActionMailer::Preview

	def sample_mail_preview
    	NewChallanMailer.new_challan_email(Citizen.last,Challan.first)
    end

end

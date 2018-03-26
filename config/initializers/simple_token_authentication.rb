SimpleTokenAuthentication.configure do |config|

config.skip_devise_trackable = false

config.identifiers = { citizen: :aadhar_no,trafficpolice: :aadhar_no }
config.header_names = {  citizen: { authentication_token: 'X-Citizen-Token', aadhar_no: 'X-Citizen-AadharNo' },trafficpolice: { authentication_token: 'X-Trafficpolice-Token', aadhar_no: 'X-Trafficpolice-AadharNo' } }

# config.header_names = {  }


  #   Then both the header names identifier key and default value are modified accordingly:
  #     `config.header_names = { super_admin: { phone_number: 'X-SuperAdmin-PhoneNumber' } }`

end

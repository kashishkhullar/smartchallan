SimpleTokenAuthentication.configure do |config|

config.skip_devise_trackable = false
config.identifiers = { citizen: :aadhar_no }
config.identifiers = { trafficpolice: :aadhar_no }

  #   Then both the header names identifier key and default value are modified accordingly:
  #     `config.header_names = { super_admin: { phone_number: 'X-SuperAdmin-PhoneNumber' } }`

config.header_names = { citizen: { authentication_token: 'X-Citizen-Token', aadhar_no: 'X-Citizen-AadharNo' } }
config.header_names = { trafficpolice: { authentication_token: 'X-Trafficpolice-Token', aadhar_no: 'X-Trafficpolice-AadharNo' } }


end

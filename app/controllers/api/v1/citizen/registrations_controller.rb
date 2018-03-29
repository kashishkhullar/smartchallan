class Api::V1::Citizen::RegistrationsController < ApplicationController
	acts_as_token_authentication_handler_for Citizen, fallback: :none

	before_action :citizen_signed_in?, only: [:destroy]
	before_action :citizen_signed_out?, only: [:create]

	def create

		puts "params"

		puts params

		puts "citizen_params"

		puts citizen_params

		@citizen = Citizen.new(citizen_params)
		if(@citizen.save)
			return render json: {status:"SUCCESS",message: "Registration Successful",data: :true},status: :created
			# render json: {status:"SUCCESS",message: "Registration Successful",data: @citizen.as_json(only: [:email,:mobile,:authentication_token,:first_name,:last_name,:dob,:aadhar_no,:dlnumber,:address,:pincode])},status: :created
		else
			return render json: {status:"ERROR",message: "Registration Failed " + @citizen.errors,data: :false},status: :unauthorized
		end



	end

	def destroy

		@citizen = Citizen.where(email: citizen_params["email"],mobile: citizen_params["mobile"],aadhar_no: citizen_params["aadhar_no"]).first

		if @citizen&.valid_password?(citizen_params[:password])
			if @citizen&.destroy
				render json: {status: "SUCCESS",message: "Account Deleted",data: @citizen.as_json(only: [:email,:first_name,:last_name,:dob,:aadhar_no,:address,:pincode,:dlnumber])},status: :ok
			else
				render json:{status: "ERROR",message: "Failure",data: :false},status: :unprocessed_entity
			end
		else
			render json:{status: "ERROR",message: "Unauthorized Access",data: :false},status: :unauthorized

		end

	end

	private

	def citizen_signed_in?
		if current_citizen
			return true
		else
			render json:{status: "ERROR",message: "Unauthorized Access",data: :false},status: :unauthorized
		end

	end

	def citizen_signed_out?
		if current_citizen.nil?
			return true
		else
			render json: {status:"ERROR",message: "Already Logged In",data: current_citizen.as_json(only: [:email,:mobile,:authentication_token,:dlnumber,:first_name,:last_name,:dob,:aadhar_no,:address,:pincode])},status: :ok
		end

	end

	def citizen_params
		params.require(:citizen).permit(:email,:password,:password_confirmation,:mobile,:first_name,:last_name,:dob,:aadhar_no,:address,:dlnumber,:pincode)
	end
end

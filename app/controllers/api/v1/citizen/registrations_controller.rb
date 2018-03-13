class Api::V1::Citizen::RegistrationsController < ApplicationController
	acts_as_token_authentication_handler_for Citizen, fallback: :none

	before_action :citizen_signed_in?, only: [:destroy]
	before_action :citizen_signed_out?, only: [:create]

	def create

		@citizen = Citizen.new(citizen_params)
		if(@citizen.save)
			render json: {status:"SUCCESS",message: "Registration Successful",data: @citizen.as_json(only: [:email,:mobile,:authentication_token,:first_name,:last_name,:dob,:aadhar_no,:address])},status: :created
		else
			render json: {status:"ERROR",message: "Registration Failed",data: :false},status: :unauthorized
		end



	end

	def destroy

		@citizen = Citizen.where(email: citizen_params["email"],mobile: citizen_params["mobile"],aadhar_no: citizen_params["aadhar_no"]).first

		if @citizen&.valid_password?(citizen_params[:password])
			if @citizen&.destroy!
				render json: {status: "SUCCESS",message: "Account Deleted",data: @citizen.as_json(only: [:email,:first_name,:last_name,:dob,:aadhar_no,:address])},status: :ok
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
		puts current_citizen
		if current_citizen.nil?
			return true
		else
			render json: {status:"ERROR",message: "Already Logged In",data: current_citizen.as_json(only: [:email,:mobile,:authentication_token,:first_name,:last_name,:dob,:aadhar_no,:address])},status: :ok
		end

	end

	def citizen_params
		params.require(:citizen).permit(:email,:password,:mobile,:first_name,:last_name,:dob,:aadhar_no,:address)
	end
end

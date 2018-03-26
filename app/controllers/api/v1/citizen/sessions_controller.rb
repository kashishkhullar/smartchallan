class Api::V1::Citizen::SessionsController < ApplicationController
	acts_as_token_authentication_handler_for Citizen, fallback: :none

	before_action :citizen_signed_in?, only: [:destroy]
	before_action :citizen_signed_out?, only: [:create]	

	def create
		puts citizen_params

		puts "now herer"

		@citizen = Citizen.where(email: citizen_params[:email],mobile: citizen_params[:mobile],aadhar_no: citizen_params["aadhar_no"]).first

		if @citizen&.valid_password?(citizen_params[:password])
			render json: {status:"SUCCESS",message: "Login Successful",data: @citizen.as_json(only: [:email,:mobile,:authentication_token,:first_name,:last_name,:dob,:aadhar_no,:address,:last_sign_in_at])},status: :created
		else
			render json: {status:"ERROR",message: "Login Failed",data: :null},status: :unauthorized
		end



	end

	def destroy

		puts current_citizen.as_json

		current_citizen&.authentication_token = nil
		if current_citizen&.save!
			#render json: {status:"SUCCESS",message: "Logout Successful",data: current_citizen.as_json(only: [:first_name,:last_name,:dob,:email,:mobile,:aadhar_no,:address])},status: :destroyed
			render json: {status:"SUCCESS",message: "Logout Successful",data: CitizenSerialzer.new(current_citizen)},status: :destroyed
		else
			#render json: {status:"ERROR",message: "Logout Failed",data: current_citizen.as_json(only: [:first_name,:last_name,:dob,:email,:mobile,:aadhar_no,:address])},status: :unauthorized
			render json: {status:"SUCCESS",message: "Logout Failed",data: CitizenSerialzer.new(current_citizen)},status: :destroyed
		end
	end

	private

	def citizen_params
		params.require(:citizen).permit(:email,:password,:mobile,:first_name,:last_name,:dob,:aadhar_no,:address)
	end

	def citizen_signed_out?
		puts "citizen is logged out"
		puts current_citizen
		if current_citizen.nil?
			return true
		else
			render json: {status:"ERROR",message: "Already Logged In",data: current_citizen.as_json(only: [:email,:mobile,:authentication_token,:first_name,:last_name,:dob,:address])},status: :ok
		end

	end

	def citizen_signed_in?
				puts current_citizen.as_json
				puts "filter here"

		if current_citizen
			return true
		else
				render json:{status: "ERROR",message: "Unauthorized Access",data: :false},status: :unauthorized
		end

	end
end

class Api::V1::Trafficpolice::SessionsController < ApplicationController
	acts_as_token_authentication_handler_for Trafficpolice, fallback: :none

	before_action :trafficpolice_signed_in?, only: [:destroy]
	before_action :trafficpolice_signed_out?, only: [:create]	

	def create
		puts trafficpolice_params

		@trafficpolice = Trafficpolice.where(email: trafficpolice_params[:email],mobile: trafficpolice_params[:mobile],aadhar_no: trafficpolice_params["aadhar_no"]).first

		if @trafficpolice&.valid_password?(trafficpolice_params[:password])
			render json: {status:"SUCCESS",message: "Login Successful",data: @trafficpolice.as_json(only: [:email,:mobile,:authentication_token,:first_name,:last_name,:dob,:aadhar_no,:address,:last_sign_in_at])},status: :created
		else
			render json: {status:"ERROR",message: "Login Failed",data: :null},status: :unauthorized
		end



	end

	def destroy

		puts current_trafficpolice.as_json

		current_trafficpolice&.authentication_token = nil
		if current_trafficpolice&.save!
			render json: {status:"SUCCESS",message: "Logout Successful",data: current_trafficpolice.as_json(only: [:first_name,:last_name,:dob,:email,:mobile,:aadhar_no,:address])},status: :destroyed
		else
			render json: {status:"ERROR",message: "Logout Failed",data: current_trafficpolice.as_json(only: [:first_name,:last_name,:dob,:email,:mobile,:aadhar_no,:address])},status: :unauthorized
		end
	end

	private

	def trafficpolice_params
		params.require(:trafficpolice).permit(:email,:password,:mobile,:first_name,:last_name,:dob,:aadhar_no,:address)
	end

	def trafficpolice_signed_out?
		if current_trafficpolice.nil?
			return true
		else
			render json: {status:"ERROR",message: "Already Logged In",data: current_trafficpolice.as_json(only: [:email,:mobile,:authentication_token,:first_name,:last_name,:dob,:address])},status: :ok
		end

	end

	def trafficpolice_signed_in?
		puts current_trafficpolice
		if current_trafficpolice
			return true
		else
				render json:{status: "ERROR",message: "Unauthorized Access",data: :false},status: :unauthorized
		end

	end
end

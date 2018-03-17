class Api::V1::Trafficpolice::RegistrationsController < ApplicationController
acts_as_token_authentication_handler_for Trafficpolice, fallback: :none

	before_action :trafficpolice_signed_in?, only: [:destroy]
	before_action :trafficpolice_signed_out?, only: [:create]

	def create

		puts params
		puts trafficpolice_params

		if trafficpolice_params[:trafficpolice_key]

			@key = TrafficpoliceKey.where(trafficpolice_key: trafficpolice_params[:trafficpolice_key]).first
			puts @key

			if @key
				@trafficpolice = Trafficpolice.new(trafficpolice_params)
				if(@trafficpolice.save)
					render json: {status:"SUCCESS",message: "Registration Successful",data: @trafficpolice.as_json(only: [:email,:mobile,:authentication_token,:first_name,:last_name,:dob,:aadhar_no,:address,:police_key,:admin_id])},status: :created
				else
					render json: {status:"ERROR",message: "Registration Failed",data: :false},status: :unauthorized
				end
			else
					render json: {status:"ERROR",message: "Registration Failed",data: :false},status: :unauthorized

			end			
		else
					render json: {status:"ERROR",message: "Registration Failed",data: :false},status: :unauthorized

		end

	end

	def destroy

		@trafficpolice = Trafficpolice.where(email: trafficpolice_params["email"],mobile: trafficpolice_params["mobile"],aadhar_no: trafficpolice_params["aadhar_no"]).first

		if @trafficpolice&.valid_password?(trafficpolice_params[:password])
			if @trafficpolice&.destroy!
				render json: {status: "SUCCESS",message: "Account Deleted",data: @trafficpolice.as_json(only: [:email,:first_name,:last_name,:dob,:aadhar_no,:address])},status: :ok
			else
				render json:{status: "ERROR",message: "Failure",data: :false},status: :unprocessed_entity
			end
		else
			render json:{status: "ERROR",message: "Unauthorized Access",data: :false},status: :unauthorized

		end

	end

	private

	def trafficpolice_signed_in?
		if current_trafficpolice
			return true
		else
			render json:{status: "ERROR",message: "Unauthorized Access",data: :false},status: :unauthorized
		end

	end

	def trafficpolice_signed_out?
		puts current_trafficpolice
		puts "hereh hrer hrere"
		if current_trafficpolice.nil?
			return true
		else
			render json: {status:"ERROR",message: "Already Logged In",data: current_trafficpolice.as_json(only: [:email,:mobile,:authentication_token,:first_name,:last_name,:dob,:aadhar_no,:address])},status: :ok
		end

	end

	def trafficpolice_params
		params.require(:trafficpolice).permit(:email,:password,:password_confirmation,:mobile,:first_name,:last_name,:dob,:aadhar_no,:address,:admin_id,:trafficpolice_key)
	end
end

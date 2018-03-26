class Api::V1::Trafficpolice::RegistrationsController < ApplicationController
acts_as_token_authentication_handler_for Trafficpolice, fallback: :none

	before_action :trafficpolice_signed_in?, only: [:destroy]
	before_action :trafficpolice_signed_out?, only: [:create]

	def create

		 puts "traffic_params"
		 puts trafficpolice_params
		puts "here is the request"

		if trafficpolice_params[:trafficpolice_key]

			puts "here"
			puts trafficpolice_params


			@key = TrafficpoliceKey.where(trafficpolice_key: trafficpolice_params['trafficpolice_key']).first
			# puts @key.trafficpolice_key

			if @key
				@trafficpolice = Trafficpolice.new(trafficpolice_params)
				puts trafficpolice_params
				if(@trafficpolice.save!)
					puts "dasdasd"
					puts @trafficpolice
					# render string: "created"
					render json: {status:"SUCCESS",message: "Registration Successful",data: @trafficpolice.as_json(only: [:email,:mobile,:authentication_token,:first_name,:last_name,:dob,:aadhar_no,:address,:trafficpolice_key,:admin_id])},status: :created
					# render json: {status:"SUCCESS",message: "Registration Successful",data: true},status: :created
				else
					render json: {status:"ERROR",message: "Registration Failed",data: :false},satus: :unauthorized
					# render json: "dasdasd"
				end
			else
					render json: {status:"ERROR",message: "Registration Failed",data: :false},status: :unauthorized
			end			
		else
					render json: {status:"ERROR",message: "Registration Failed",data: :false},status: :unauthorized
		end
		# render json: "response"

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
		# puts current_trafficpolice
		# puts "hereh hrer hrere"
		if current_trafficpolice
		# 	return true
		# else
			render json: {status:"ERROR",message: "Already Logged In",data: current_trafficpolice.as_json(only: [:email,:mobile,:authentication_token,:first_name,:last_name,:dob,:aadhar_no,:address])},status: :ok
		end

	end

	def trafficpolice_params
	  # params
	  # puts "params as json"
	  # puts params.as_json
	  # puts "test"
	  # puts params.keys.first.as_json
	  # params.keys.first.as_json
	  # return JSON.parse(params.keys.first)
	  params.require(:trafficpolice).permit(:email,:password,:password_confirmation,:mobile,:first_name,:last_name,:dob,:aadhar_no,:address,:admin_id,:trafficpolice_key)
	end
end

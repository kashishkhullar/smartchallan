class Api::V1::Commercial::RegistrationsController < ApplicationController
	acts_as_token_authentication_handler_for Commercial, fallback: :none

	before_action :commercial_signed_in?, only: [:destroy]
	before_action :commercial_signed_out?, only: [:create]

	def create

		@commercial = Commercial.new(commercial_params)
		if(@commercial.save)
			render json: {status:"SUCCESS",message: "Registration Successful",data: @commercial.as_json(only: [:email,:mobile,:authentication_token,:phone_no,:company_name,:owner_name,:identification_no,:address])},status: :created
		else
			render json: {status:"ERROR",message: "Registration Failed",data: :false},status: :unauthorized
		end



	end

	def destroy

		@commercial = Commercial.where(email: commercial_params["email"],mobile: commercial_params["mobile"],identification_no: commercial_params["identification_no"]).first

		if @commercial&.valid_password?(commercial_params[:password])
			if @commercial&.destroy!
				render json: {status: "SUCCESS",message: "Account Deleted",data: @commercial.as_json(only: [:email,:mobile,:phone_no,:company_name,:owner_name,:identification_no,:address])},status: :ok
			else
				render json:{status: "ERROR",message: "Failure",data: :false},status: :unprocessed_entity
			end
		else
			render json:{status: "ERROR",message: "Unauthorized Access",data: :false},status: :unauthorized

		end

	end

	private

	def commercial_signed_in?
		if current_commercial
			return true
		else
			render json:{status: "ERROR",message: "Unauthorized Access",data: :false},status: :unauthorized
		end

	end

	def commercial_signed_out?
		puts current_commercial
		if current_commercial.nil?
			return true
		else
			render json: {status:"ERROR",message: "Already Logged In",data: current_commercial.as_json(only: [:email,:mobile,:authentication_token,:phone_no,:company_name,:owner_name,:identification_no,:address])},status: :ok
		end

	end

	def commercial_params
		params.require(:commercial).permit(:email,:password,:password_confirmation,:mobile,:phone_no,:company_name,:owner_name,:identification_no,:address)
	end
end

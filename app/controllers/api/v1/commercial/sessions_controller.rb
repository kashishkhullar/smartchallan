class Api::V1::Commercial::SessionsController < ApplicationController
	acts_as_token_authentication_handler_for Commercial, fallback: :none

	before_action :commercial_signed_in?, only: [:destroy]
	before_action :commercial_signed_out?, only: [:create]	

	def create
		puts commercial_params

		@commercial = Commercial.where(email: commercial_params["email"],mobile: commercial_params["mobile"],identification_no: commercial_params["identification_no"]).first

		if @commercial&.valid_password?(commercial_params[:password])
			render json: {status:"SUCCESS",message: "Login Successful",data: @commercial.as_json(only: [:email,:mobile,:authentication_token,:phone_no,:company_name,:owner_name,:identification_no,:address,:last_sign_in_at])},status: :created
		else
			render json: {status:"ERROR",message: "Login Failed",data: :null},status: :unauthorized
		end



	end

	def destroy

		puts current_commercial.as_json

		current_commercial&.authentication_token = nil
		if current_commercial&.save!
			render json: {status:"SUCCESS",message: "Logout Successful",data: current_commercial.as_json(only: [:email,:mobile,:phone_no,:company_name,:owner_name,:identification_no,:address])},status: :destroyed
		else
			render json: {status:"ERROR",message: "Logout Failed",data: current_commercial.as_json(only: [:email,:mobile,:phone_no,:company_name,:owner_name,:identification_no,:address])},status: :unauthorized
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

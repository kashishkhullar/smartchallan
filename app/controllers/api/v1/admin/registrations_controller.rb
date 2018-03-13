class Api::V1::Admin::RegistrationsController < ApplicationController
	acts_as_token_authentication_handler_for Admin, fallback: :none

	before_action :admin_signed_in?, only: [:destroy]
	before_action :admin_signed_out?, only: [:create]

	def create

		@admin = Admin.new(admin_params)

		if(@admin.save!)
			render json: {status:"SUCCESS",message: "Registration Successful",data: @admin.as_json(only: [:email,:mobile,:authentication_token])},status: :created
		else
			render json: {status:"ERROR",message: "Registration Failed",data: :false},status: :unauthorized
		end



	end

	def destroy

		@admin = Admin.where(email: admin_params["email"],mobile: admin_params["mobile"]).first

		if @admin&.valid_password?(admin_params[:password])
			if @admin&.destroy!
				render json: {status: "SUCCESS",message: "Account Deleted",data: @admin.as_json(only: [:email])},status: :ok
			else
				render json:{status: "ERROR",message: "Failure",data: :false},status: :unprocessed_entity
			end
		else
				render json:{status: "ERROR",message: "Unauthorized Access",data: :false},status: :unauthorized

		end

	end

	private

	def admin_signed_in?
		if current_admin
			return true
		else
				render json:{status: "ERROR",message: "Unauthorized Access",data: :false},status: :unauthorized
		end

	end

	def admin_signed_out?
		if current_admin.nil?
			return true
		else
			render json: {status:"ERROR",message: "Already Logged In",data: current_admin.as_json(only: [:email,:mobile,:authentication_token])},status: :ok
		end

	end

	def admin_params
		params.require(:admin).permit(:email,:password,:password_confirmation,:mobile)
	end
end

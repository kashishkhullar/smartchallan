class Api::V1::Admin::SessionsController < ApplicationController
	acts_as_token_authentication_handler_for Admin, fallback: :none

	before_action :admin_signed_in?, only: [:destroy]
	before_action :admin_signed_out?, only: [:create]	

	def create
		puts admin_params

		@admin = Admin.where(email: admin_params[:email],mobile: admin_params[:mobile]).first

		if @admin&.valid_password?(admin_params[:password])
			render json: {status:"SUCCESS",message: "Login Successful",data: @admin.as_json(only: [:email,:mobile,:authentication_token,:last_sign_in_at])},status: :created
		else
			render json: {status:"ERROR",message: "Login Failed",data: :null},status: :unauthorized
		end



	end

	def destroy

		puts current_admin.as_json

		current_admin&.authentication_token = nil
		if current_admin&.save!
			render json: {status:"SUCCESS",message: "Logout Successful",data: current_admin.as_json(only: [:email,:mobile])},status: :destroyed
		else
			render json: {status:"ERROR",message: "Logout Failed",data: current_admin.as_json(only: [:email,:mobile])},status: :unauthorized
		end
	end

	private

	def admin_params
		params.require(:admin).permit(:email,:mobile,:password)
	end

	def admin_signed_out?
		if current_admin.nil?
			return true
		else
			render json: {status:"ERROR",message: "Already Logged In",data: current_admin.as_json(only: [:email,:mobile,:authentication_token])},status: :ok
		end

	end

	def admin_signed_in?
		if current_admin
			return true
		else
				render json:{status: "ERROR",message: "Unauthorized Access",data: :false},status: :unauthorized
		end

	end


end

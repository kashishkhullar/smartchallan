class Api::V1::Admin::RegistrationsController < ApplicationController
	acts_as_token_authentication_handler_for Admin, fallback: :none

	before_action :admin_signed_in?, only: [:destroy,:create_traffic_police]
	before_action :admin_signed_out?, only: [:create]

	def create

		if admin_params[:admin_key]

			@key = AdminKey.where(admin_key: admin_params[:admin_key]).first

			if @key
				@admin =Admin.new(admin_params)
				if(@admin.save!)
					# render json: {status:"SUCCESS",message: "Registration Successful",data: @admin.as_json(only: [:email,:mobile,:authentication_token])},status: :created
					render json: {status:"SUCCESS",message: "Registration Successful",data: AdminSerializer.new(@admin)},status: :created
				else
					render json: {status:"ERROR",message: "Registration Failed error while saving",data: :false},status: :unauthorized
				end
			else
					render json: {status:"ERROR",message: "Registration Failed key not found",data: :false},status: :unauthorized
			end
		else
					render json: {status:"ERROR",message: "Registration Failed key missing in params",data: :false},status: :unauthorized

		end
	end

	def destroy

		@admin = Admin.where(email: admin_params["email"],mobile: admin_params["mobile"]).first

		if @admin&.valid_password?(admin_params[:password])
			if @admin&.destroy!
				render json: {status: "SUCCESS",message: "Account Deleted",data: @admin.as_json(only: [:email])},status: :ok
			else
				render json:{status: "ERROR",message: "Failure error whiel destroying",data: :false},status: :unprocessed_entity
			end
		else
				render json:{status: "ERROR",message: "Unauthorized Access credentials invalid",data: :false},status: :unauthorized

		end

	end

	def create_admin

		@admin_key = AdminKey.new
		@admin_key.admin_key = (0...8).map { (65 + rand(26)).chr }.join
		@admin_key.save
		render json:{status: "SUCCESS",message: "Admin Account Created",data: @admin_key.as_json(only:[:admin_key])},status: :ok
	end

	def create_traffic_police

		@trafficpolice_key = TrafficpoliceKey.new
		@trafficpolice_key.trafficpolice_key = (0...8).map { (65 + rand(26)).chr }.join
		@trafficpolice_key.save
		render json:{status: "SUCCESS",message: "Traffic Police Account Created",data: @trafficpolice_key.as_json(only:[:trafficpolice_key])},status: :ok
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
		params.require(:admin).permit(:email,:password,:password_confirmation,:mobile,:admin_key)
	end
end

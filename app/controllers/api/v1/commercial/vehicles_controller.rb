class Api::V1::Commercial::VehiclesController < ApplicationController
	acts_as_token_authentication_handler_for Commercial, fallback: :none
	before_action :commercial_signed_in?

	def create
		@vehicle = Vehicle.where(registration_no: commercial_vehicle_params[:registration_no]).first
		if @vehicle
			@vehicle.commercial_id = current_commercial.id
			if @vehicle.save
				render json:{status: "SUCCESS",message: "Vehicle Registersed Successfully",data: @vehicle.as_json},status: :created
			else

				render json: {status:"ERROR",message: "Vehicle Registration Failed",data: :false},status: :unprocessed_entity
			end

		else
				render json: {status:"ERROR",message: "Vehicle Not Found",data: :false},status: :unprocessed_entity

		end

	end

	def destroy
		@vehicle = Vehicle.where(registration_no: commercial_vehicle_params[:registration_no]).first
		if @vehicle
			@vehicle.commercial_id = nil
				render json:{status: "SUCCESS",message: "Vehicle Unregistersed Successfully",data: @vehicle.as_json},status: :created
			else

				render json: {status:"ERROR",message: "Vehicle Unregistration Failed",data: :false},status: :unprocessed_entity
			end

		else
				render json: {status:"ERROR",message: "Vehicle Not Found",data: :false},status: :unprocessed_entity

		end
	end


	private

	def commercial_vehicle_params
		params.require(:vehicle).permit(:registration_no)
	end

	def commercial_signed_in?
		if current_commercial
			return true
		else
			render json:{status: "ERROR",message: "Unauthorized Access",data: :false},status: :unauthorized
		end
	end

end

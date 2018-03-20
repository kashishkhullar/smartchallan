class Api::V1::Commercial::DriversController < ApplicationController

	acts_as_token_authentication_handler_for Commercial, fallback: :none
	before_action :commercial_signed_in?

	def index
		@commercialdrivers = current_commercial.commercialdrivers
		render json: {status:"SUCCESS",message: "Loaded Commercial Driver Record",data: @commercialdrivers.as_json(include: [:vehicle,:citizen])},status: :ok
	end

	def show
		@vehicle = Vehicle.where(registration_no: driver_params[:registration_no]).first

		if @vehicle
			@commercialdriver = current_commercial.commercialdrivers.where(vehicle_id: @vehicle.id).first
				render json: {status:"SUCCESS",message: "Loaded Commercial Driver Record",data: @commercialdriver.as_json(include: [:vehicle,:citizen])},status: :ok
		else
				render json: {status:"ERROR",message: "Vehicle Not Found",data: :false},status: :unprocessed_entity
		end

	end

	def create
		@commercialdriver = Commercialdriver.new
		@commercialdriver.commercial_id = current_commercial.id
		@commercialdriver.citizen_id = Citizen.where(aadhar_no: driver_params[:aadhar_no]).first.id
		@commercialdriver.vehicle_id = Vehicle.where(registration_no: driver_params[:registration_no]).first.id
		@commercialdriver.start_date = driver_params[:start_date]
		@commercialdriver.end_date = driver_params[:end_date]
		if @commercialdriver.save
			render json: {status:"SUCCESS",message: "Driver Record Created Successfully",data: @commercialdriver.as_json(include: [:vehicle,:citizen])},status: :ok
		else
			render json: {status:"ERROR",message: "Driver Record Creation Failed",data: :false},status: :unprocessed_entity
		end
	end

	def update
		@commercialdriver.citizen_id = Citizen.where(aadhar_no: driver_params[:aadhar_no]).first.id
		@commercialdriver.vehicle_id = Vehicle.where(registration_no: driver_params[:registration_no]).first.id
		@commercialdriver.start_date = driver_params[:start_date]
		@commercialdriver.end_date = driver_params[:end_date]
		if @commercialdriver.save
			render json: {status:"SUCCESS",message: "Driver Record Updated Successfully",data: @commercialdriver.as_json(include: [:vehicle,:citizen])},status: :ok
		else
			render json: {status:"ERROR",message: "Driver Record Updation Failed",data: :false},status: :unprocessed_entity
		end
	end

	def destroy
		@vehicle = Vehicle.where(registration_no: driver_params[:registration_no]).first
		@commercialdriver = Commercialdriver.where(vehicle_id: @vehicle.id,commercial_id: current_commercial.id).first
		if @commercialdriver.destory
			render json: {status:"SUCCESS",message: "Driver Record Deleted Successfully",data: @commercialdriver.as_json(include: [:vehicle,:citizen])},status: :ok
		else
			render json: {status:"ERROR",message: "Driver Record Deletion Failed",data: :false},status: :unprocessed_entity
		end
	end

	private

	def driver_params
		params.require(:commercialdriver).permit(:registration_no,:aadhar_no,:start_date,:end_date)
	end

	def commercial_signed_in?
		if current_commercial
			return true
		else
			render json:{status: "ERROR",message: "Unauthorized Access",data: :false},status: :unauthorized
		end
	end
end

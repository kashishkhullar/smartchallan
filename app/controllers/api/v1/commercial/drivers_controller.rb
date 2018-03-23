class Api::V1::Commercial::DriversController < ApplicationController

	acts_as_token_authentication_handler_for Commercial, fallback: :none
	before_action :commercial_signed_in?, only: [:index,:show,:create,:destory,:update]


	def index
		@commercialdrivers = current_commercial.commercialdrivers
		render json: {status:"SUCCESS",message: "Loaded Commercial Driver Record",data: ActiveModel::Serializer::CollectionSerializer.new(@commercialdrivers, each_serializer: CommercialdriverSerializer)},status: :ok
	end

	def show
		@vehicle = Vehicle.where(registration_no: driver_params[:registration_no]).first

		if @vehicle
				@commercialdriver = current_commercial.commercialdrivers.where(vehicle_id: @vehicle.id).first
				if @commercialdriver
					render json: {status:"SUCCESS",message: "Loaded Commercial Driver Record",data:CommercialdriverSerializer.new(@commercialdriver)},status: :ok
				else
					render json: {status:"ERROR",message: "Record Not Found",data: :false},status: :unprocessed_entity
				end

		else
				render json: {status:"ERROR",message: "Vehicle Not Found",data: :false},status: :unprocessed_entity
		end

	end

	def create
		@commercialdriver = Commercialdriver.new
		@commercialdriver.commercial_id = current_commercial.id
		citizen = Citizen.where(aadhar_no: driver_params[:aadhar_no]).first
		
		unless citizen
			return render json: {status:"ERROR",message: "Driver Not Found",data: :false},status: :unprocessed_entity
		else
			@commercialdriver.citizen_id = citizen.id
		end
		vehicle = Vehicle.where(registration_no: driver_params[:registration_no]).first
		unless vehicle
			return render json: {status:"ERROR",message: "Vehicle Not Found",data: :false},status: :unprocessed_entity
		else
			@commercialdriver.vehicle_id = vehicle.id
		end
		@commercialdriver.start_date = driver_params[:start_date]
		@commercialdriver.end_date = driver_params[:end_date]
		if @commercialdriver.save!
			return render json: {status:"SUCCESS",message: "Driver Record Created Successfully",data: CommercialdriverSerializer.new(@commercialdriver)},status: :ok
		else
			return render json: {status:"ERROR",message: "Driver Record Creation Failed",data: :false},status: :unprocessed_entity
		end
	end

	def update

		vehicle = Vehicle.where(registration_no: driver_params[:registration_no]).first
		@commercialdriver = Commercialdriver.where(vehicle_id: vehicle.id,commercial_id: current_commercial.id).first
		puts @commercialdriver
		citizen = Citizen.where(aadhar_no: driver_params[:aadhar_no]).first
		unless citizen
			return render json: {status:"ERROR",message: "Driver Not Found",data: :false},status: :unprocessed_entity
		else
			if @commercialdriver.citizen_id != citizen.id
				@commercialdriver.citizen_id = citizen.id
			end
		end
		vehicle = Vehicle.where(registration_no: driver_params[:registration_no]).first
		unless vehicle
			return render json: {status:"ERROR",message: "Vehicle Not Found",data: :false},status: :unprocessed_entity
		else
			if @commercialdriver.vehicle_id != vehicle.id
				@commercialdriver.vehicle_id = vehicle.id
			end
		end
		if @commercialdriver.start_date != driver_params[:start_date]
			@commercialdriver.start_date = driver_params[:start_date]
		end
		if @commercialdriver.end_date != driver_params[:end_date]
			@commercialdriver.end_date = driver_params[:end_date]
		end
		if @commercialdriver.save
			render json: {status:"SUCCESS",message: "Driver Record Updated Successfully",data: CommercialdriverSerializer.new(@commercialdriver)},status: :ok
		else
			render json: {status:"ERROR",message: "Driver Record Updation Failed",data: :false},status: :unprocessed_entity
		end
	end

	def destroy
		@vehicle = Vehicle.where(registration_no: driver_params[:registration_no]).first
		@commercialdriver = Commercialdriver.where(vehicle_id: @vehicle.id,commercial_id: current_commercial.id).first
		if @commercialdriver.destroy!
			render json: {status:"SUCCESS",message: "Driver Record Deleted Successfully",data: CommercialdriverSerializer.new(@commercialdriver)},status: :ok
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

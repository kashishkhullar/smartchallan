class Api::V1::ChallansController < ApplicationController

	acts_as_token_authentication_handler_for Trafficpolice, fallback: :none

	before_action :trafficpolice_signed_in?, only: [:create,:update,:destroy]


	def index
		# @challans = Vehicle.where(registration_no:challan_params[:registration_no]).first.challans
		vehicle = Vehicle.where(registration_no:challan_params[:registration_no]).first
		puts vehicle
		if vehicle
			@challans = vehicle.challans
		else
			@challans = nil
		end
		# render json: {status:"SUCCESS",message: "Loaded Challans",data: @challans.as_json(only: [:id,:challantype_id,:date_of_issue,:time_of_issue,:latitude,:longitude,:address,:due_date])},status: :ok
		# render json: {status:"SUCCESS",message: "Loaded Challan",data: @challans.as_json(include: [:vehicle,:challantype,:citizen,:trafficpolice])},status: :ok
		render json: {status:"SUCCESS",message: "Loaded Challan",data: ActiveModel::Serializer::CollectionSerializer.new(@challans, each_serializer: ChallanSerializer)},status: :ok
	end

	def show
		@challan = Challan.where(id:challan_params[:challan_id]).first
		# render json: {status:"SUCCESS",message: "Loaded Challan",data: @challan.as_json(include: [:vehicle,:challantype,:citizen,:trafficpolice])},status: :ok
		render json: {status:"SUCCESS",message: "Loaded Challan",data: ChallanSerializer.new(@challan)},status: :ok
	end

	def show_dated
		@challans = Challan.where(date_of_issue:params[:challan][:date])
		render json: {status:"SUCCESS",message: "Loaded Challan",data: ActiveModel::Serializer::CollectionSerializer.new(@challans, each_serializer: ChallanSerializer)},status: :ok

	end

	def create
		# puts params
		@challan = Challan.new(challan_params)
		# puts @challan.as_json
		@vehicle = Vehicle.where(registration_no: params[:challan][:registration_no]).first
		# puts "vehicle"
		# puts @vehicle.as_json
		@challan.vehicle_id = @vehicle.id
		@challan.citizen_id = @vehicle.citizen.id
		@challan.trafficpolice_id = current_trafficpolice.id
		@challan.due_date = DateTime.now.to_date + 7.days
		if @challan.save
			render json: {status:"SUCCESS",message: "Challan Created Successfully",data: ActiveModel::Serializer::CollectionSerializer.new(@challans, each_serializer: ChallanSerializer)},status: :ok
		else
			render json: {status:"ERROR",message: "Challan Creation Failed",data: :false},status: :unprocessed_entity
		end
	end

	def update
	end

	def destroy
	end

	private

	def challan_params
		params.require(:challan).permit(:challan_id,:challantype_id,:date_of_issue,:time_of_issue,:latitude,:longitude,:address,:registration_no)
	end


	def trafficpolice_signed_in?
		puts current_trafficpolice
		puts params
		if current_trafficpolice
			return true
		else
			render json:{status: "ERROR",message: "Unauthorized Access abe chal jaa",data: :false},status: :unauthorized
		end

	end

end

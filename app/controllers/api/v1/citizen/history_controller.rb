class Api::V1::Citizen::HistoryController < ApplicationController

	acts_as_token_authentication_handler_for Citizen, fallback: :none

	before_action :citizen_signed_in?
	def paid

		@challans = current_citizen.challans.where(paid: :true)

		if @challans
			render json: {status:"SUCCESS",message: "Loaded Challan",data: ActiveModel::Serializer::CollectionSerializer.new(@challans, each_serializer: ChallanSerializer)},status: :ok
		else
			render json:{status: "SUCCESS",message: "Challans not found",data: :false},status: :ok
		end

	end

	def unpaid

		@challans = current_citizen.challans.where(paid: :false)

		if @challans
			render json: {status:"SUCCESS",message: "Loaded Challan",data: ActiveModel::Serializer::CollectionSerializer.new(@challans, each_serializer: ChallanSerializer)},status: :ok
		else
			render json:{status: "SUCCESS",message: "Challans not found",data: :false},status: :ok

		end

	end


	private

	def citizen_signed_in?
		puts current_citizen.as_json
		puts "above hree"
		if current_citizen
			return true
		else
			render json:{status: "ERROR",message: "Unauthorized Access",data: :false},status: :unauthorized
		end

	end




end

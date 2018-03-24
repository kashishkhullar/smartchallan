class SendNewChallanMailJob < ApplicationJob
  queue_as :default

  def perform(challan)
    # Do something later
    @challan = challan
    NewChallanMailer.new_challan_email(@challan.citizen,@challan).deliver_later
  end
end

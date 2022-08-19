class Owner::BookingsController < ApplicationController
  def index
    @bookings = policy_scope([:owner, Booking])
    @offers = Offer.where(user: current_user)
  end
end

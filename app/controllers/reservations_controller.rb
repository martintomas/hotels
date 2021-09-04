# frozen_string_literal: true

class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all.order(created_at: :desc)
  end

  def new
    @reservation = Reservation.new forwarded_params
  end

  def create
    @reservation = Reservation.new reservation_params
    if @reservation.save
      render turbo_stream: turbo_stream.replace('content', partial: 'success')
    else
      render :new
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit :first_name, :last_name, :email, :phone, :arrival_date, :departure_date,
                                        :number_of_rooms, :hotel_id
  end

  def forwarded_params
    params.permit :arrival_date, :departure_date, :number_of_rooms, :hotel_id
  end
end

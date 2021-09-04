# frozen_string_literal: true

class HotelsController < ApplicationController
  def index
    @search_former = Hotels::SearchFormer.new
  end

  def search
    @search_former = Hotels::SearchFormer.new search_params
    respond_to do |format|
      format.turbo_stream do
        if @search_former.valid?
          render turbo_stream: [turbo_stream.replace('searching', partial: '/hotels/search_form',
                                                                  locals: { search_former: @search_former }),
                                turbo_stream.replace('content', template: '/hotels/index')]
        else
          render turbo_stream: turbo_stream.replace('searching', partial: '/hotels/search_form',
                                                                 locals: { search_former: @search_former })
        end
      end
    end
  end

  private

  def search_params
    params.fetch(:hotels_search_former, {})
          .permit(:arrival_date, :departure_date, :number_of_rooms, :max_price_per_room)
  end
end

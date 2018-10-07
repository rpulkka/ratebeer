class PlacesController < ApplicationController
  def index
  end

  def search
    @places = BeermappingApi.places_in(params[:city])
    @weather_data = ApixuApi.weather_in(params[:city])
    @city = params[:city]
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
    @id = params[:id]
    @place_data = BeermappingApi.place_by_id(@id)
    @weather_data = ApixuApi.weather_in(params[:city])
  end
end

require 'open-uri'
require 'json'

class CoordsController < ApplicationController
  def fetch_weather
    @latitude = 42.0538387
    @longitude = -87.67721
    your_api_key = "4966eeb240591c7cbca31d5b97ab647e"

    # Your code goes here.
    url = "https://api.forecast.io/forecast/"+your_api_key+"/"+@latitude+","+@longitude
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    results = parsed_data["results"]
    # @temperature = ?
    # @minutely_summary = ?
    # @hourly_summary = ?
    # @daily_summary = ?

@address = params["address"]

    if @address == nil
        @address ="corner Foster and Sheridan"
    end

    @url_safe_address = URI.encode(@address)


    # Your code goes here.
    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+@url_safe_address+"&sensor=true"
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    results = parsed_data["results"]

    first = results[0]
    geometry = first["geometry"]
    location = geometry["location"]
    @latitude = location["lat"]
    @longitude = location["lng"]

  end
end

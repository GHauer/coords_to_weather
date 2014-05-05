require 'open-uri'
require 'json'

class CoordsController < ApplicationController
  def fetch_weather

     @address = params["address"]

        if @address == nil
            @address ="corner Foster and Sheridan"
        end

        @url_safe_address = URI.encode(@address)

    url = "http://maps.googleapis.com/maps/api/geocode/json?address="+@url_safe_address+"&sensor=true"
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    results = parsed_data["results"]

    first = results[0]
    geometry = first["geometry"]
    location = geometry["location"]
    @latitude = location["lat"]
    @longitude = location["lng"]


    #@latitude = params["address"]
    #@longitude = params["address"]

    your_api_key = "4966eeb240591c7cbca31d5b97ab647e"


    # Your code goes here.
    url = "https://api.forecast.io/forecast/#{your_api_key}/#{@latitude},#{@longitude}"
    raw_data = open(url).read
    parsed_data = JSON.parse(raw_data)
    @temperature = parsed_data["currently"]["temperature"]

    @minutely_summary = parsed_data["minutely"]["summary"]
    @hourly_summary = parsed_data["hourly"]["summary"]
    @daily_summary = parsed_data["daily"]["summary"]

    end
end

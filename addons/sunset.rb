require 'net/http'
require 'json'
require 'date'
require 'sun-times'

class Sunset
	def initialize(city)
		@city = city
		@time = sunsetcalc(city)
	end
	attr_reader :time
	attr_reader :city

	def sunsetcalc(city)
		uri = URI('https://maps.googleapis.com/maps/api/geocode/json?address=' + city)
		geodata = JSON.parse(Net::HTTP.get(uri))
		geodata = geodata["results"][0]["geometry"]["location"]

		lat = geodata["lat"]
		lng = geodata["lng"]

		return SunTimes.set(Date.today, lat, lng).getlocal.to_s[0..18]
	end
end

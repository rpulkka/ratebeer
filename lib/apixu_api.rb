class ApixuApi

  def self.weather_in(city)
    url = "http://api.apixu.com/v1/current.json?key=#{key}&q="

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["current"]

    return places
  end

  def self.key
    "f28128aec83c48e5acd174156180710"
    #raise "APIXU_APIKEY env variable not defined" if ENV['APIXU_APIKEY'].nil?
    #ENV['APIXU_APIKEY']
  end
end
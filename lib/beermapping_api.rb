class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city) { get_places_in(city) }
    # expires_in: 1.minute
  end

  def self.get_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do | place |
      Place.new(place)
    end
  end

  def self.place_by_id(id)
    url = "http://beermapping.com/webservice/locquery/#{key}/#{id}"

    response = HTTParty.get "#{url}"
    place = response.parsed_response["bmp_locations"]["location"]

    return [] if place['id'].nil?

    place
  end

  def self.key
    raise "BEERMAPPING_APIKEY env variable not defined" if ENV['BEERMAPPING_APIKEY'].nil?
    ENV['BEERMAPPING_APIKEY']
  end
end

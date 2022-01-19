require 'uri'
require 'net/http'
require 'json'

class DeliveryCalculator
  def self.get_distance(origin, destination)
    url = URI("https://api.distancematrix.ai/maps/api/distancematrix/json?origins=#{origin}&destinations=#{destination}&key=zVFyFyVUWAAFZP1NhwkDhzHrCF2eD")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)
    response = https.request(request)

    parsed_response = JSON.parse(response.read_body.gsub('=>', ':'))
    response_status = parsed_response['rows'][0]['elements'][0]['status']
    case response_status
    when 'ZERO_RESULTS'
      response_status
    when 'OK'
      parsed_response['rows'][0]['elements'][0]['distance']['text'].to_f
    else
      'Error'
    end
  end

  def self.calculate_price(weight, length, width, height, distance)
    return -1 if length == 0.0 || width == 0.0 || height == 0.0 || weight == 0.0

    volume = length * width * height
    return (1 * distance) if volume < 1_000_000.0
    return (2 * distance) if weight < 10.0
    (3 * distance)
  end

end
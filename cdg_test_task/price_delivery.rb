require 'uri'
require 'net/http'
require 'json'

class PriceDelivery
  attr_accessor :weight, :length, :width, :height, :distance, :price

  def initialize(params = {})
    @weight = params.fetch(:weight, 0)
    @length = params.fetch(:length, 0)
    @width = params.fetch(:width, 0)
    @height = params.fetch(:height, 0)
    @distance = params.fetch(:distance, 0)
    @price = 0
  end

  def get_distance(origin, destination)
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
      parsed_response['rows'][0]['elements'][0]['distance']['text']
    else
      'Error'
    end
  end

  def calculate_price()
    return -1 if length.zero? || width.zero? || height.zero? || weight.zero?

    volume = length * width * height
    return 1 * distance.to_f if volume < 1_000_000
    return 2 * distance.to_f if weight < 10
    3 * distance.to_f

  end
  def get_delivery_info()
    {weight: weight, length: length, width: width, height: height, distance: distance, price: price}
  end




end
def start()

end
test, test1 = PriceDelivery.new(weight: 5, length: 10, width: 10, height: 10)
# test2 = PriceDelivery.new(weight: 5, length: 100, width: 100, height: 200)
# test3 = PriceDelivery.new(weight: 15, length: 100, width: 200, height: 200)
# puts "Enter origin city: \n"
# origin = gets.chomp
# puts "Enter destination city: \n"
# destination = gets.chomp
# puts tets.get_distance(origin, destination)
# puts test.get_distance("Seattle", "New York")
# puts test.get_distance('Seattle', 'Russia, Moscow')
# puts test.get_distance('Seattle', 'New York')
puts test.get_delivery_info

# puts (test1.cost_calculation('Seattle', 'New York'))
# puts (test2.cost_calculation('Seattle', 'New York'))
# puts (test3.cost_calculation('Seattle', 'New York'))
json.extract! delivery, :id, :first_name, :middle_name, :last_name, :phone_number, :email, :weight, :length, :width, :height, :origin, :destination, :created_at, :updated_at
json.url delivery_url(delivery, format: :json)

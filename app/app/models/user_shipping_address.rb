class UserShippingAddress < ActiveRecord::Base
  def full_address
    "#{address_line_1} #{address_line_2}  #{country} #{postal_code}"
  end
end

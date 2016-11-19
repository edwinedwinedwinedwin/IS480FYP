class Payment < ActiveRecord::Base

    #validates :user_shipping_address_id, presence: { message: "Please create a user shipping address." }

	def paypal_url(return_path)    
    values = {
        business: "ybcosg-facilitator@gmail.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: self.id,
        amount: self.amount,
        item_name: self.project_reward_name,
        item_number: self.project_reward_id,
        quantity: '1'
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end
end

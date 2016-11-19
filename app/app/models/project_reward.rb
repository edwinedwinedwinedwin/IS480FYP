class ProjectReward < ActiveRecord::Base

  belongs_to :project

  mount_uploader :img_url, ProjectRewardImgUploader
  validates :img_url, file_size: { less_than: 5.megabytes } ,:on => :create
  validates :name, :min_amount, :estimated_delivery, :no_of_rewards, :presence => { :message => " cannot be blank" },:on => :create


  def paypal_url(return_url)
    #@project_reward=ProjectReward.find(params[:pid])
    values = {
        business: "ybcosg-facilitator@gmail.com",
        cmd: "_cart",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
        amount: min_amount,
        item_name: name,
        item_number: id,
        quantity: '1'
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

end

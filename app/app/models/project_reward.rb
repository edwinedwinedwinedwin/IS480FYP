class ProjectReward < ActiveRecord::Base
  belongs_to :project

  mount_uploader :img_url, ProjectRewardImgUploader
  validates :img_url, file_size: { less_than: 2.megabytes }  
  validates :name, :min_amount, :estimated_delivery, :no_of_rewards, :presence => { :message => " cannot be blank" },:on => :create
  validates :min_amount, :no_of_rewards, :numericality => true, :allow_nil => true
end

class ProjectProposal < ActiveRecord::Base
  include ActiveModel::Validations

  has_many :project_proposal_imgs
  belongs_to :project_category
  belongs_to :project_status
  has_one :project

  validates_uniqueness_of :title, client_validations: {class: ProjectProposal}
  validates_presence_of :title, :country
  validates_presence_of :description, :company_url, :estimated_amt_raise
  validates_presence_of :name, :email, :creator_title

  validate :end_date_after_start_date?
  validate :start_date_before_today?

  def end_date_after_start_date?
   if  :estimated_start_date != :estimated_end_date
    if :estimated_start_date > :estimated_end_date

      errors.add :estimated_end_date, "end date must be after start date."
    end
   end
  end

  def start_date_before_today?
    if estimated_start_date < Time.now.to_date
      errors.add :estimated_start_date, "start date must be today onward."
    end
  end


end


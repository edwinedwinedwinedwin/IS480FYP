class PagesController < ApplicationController
  skip_before_action :authorize, only: [:home, :comrules, :term]
  def home

  end

  def comrules

  end

  def term

  end
end

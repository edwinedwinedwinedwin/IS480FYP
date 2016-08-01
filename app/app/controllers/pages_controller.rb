class PagesController < ApplicationController
  skip_before_action :logged_in, only: [:home, :comrules, :term]
  def home

  end

  def comrules

  end

  def term

  end
end

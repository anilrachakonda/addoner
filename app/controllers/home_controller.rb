class HomeController < ApplicationController

  def index
    @browser_types = ['Firefox', 'Chrome']

    respond_to do |format|
      format.html # index.html.haml
    end
  end

end
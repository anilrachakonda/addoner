class HomeController < ApplicationController

  def index
    #@users = User.all
    @browser_types = ['Firefox', 'Chrome']

    respond_to do |format|
      format.html # index.html.haml
    end
  end

end

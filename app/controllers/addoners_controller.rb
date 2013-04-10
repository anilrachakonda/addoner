class AddonersController < ApplicationController
  
  def create_extension
    @browser_type = params[:browser_type] || ''
    respond_to do |format|
      format.html # create_extension.html.haml
    end
  end

end

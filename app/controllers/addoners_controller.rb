class AddonersController < ApplicationController

  BROWSER_LIST = ["firefox", "chrome"]

  def create_extension
    @browser_type = params[:browser_type] || ''
    if @browser_type.blank? || @browser_type && !BROWSER_LIST.include?(@browser_type.downcase)
      redirect_to root_path
    else
      respond_to do |format|
        format.html # create_extension.html.haml
      end
    end
  end

end
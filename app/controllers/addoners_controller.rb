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

  def download_sample_extension
    browser_type = params[:browser_type] || nil
    if browser_type
      path = "#{Rails.root}"+"/public/"
      if browser_type == "firefox"
        path = path + "sample_firefox_extension.zip"
        send_file path, :filename => "sample_firefox_extension.zip"
      elsif browser_type == "chrome"
        path = path + "sample_chrome_extension.zip"
        send_file path, :filename => "sample_chrome_extension.zip"
      end
    end
  end

end
class AddonersController < ApplicationController

  BROWSER_LIST = ["firefox", "chrome"]

  gem 'rubyzip'
  require 'zip/zip'
  require 'zip/zipfilesystem'

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
      path = "#{Rails.root}"+"/public/user_extensions/#{browser_type}/sample_#{browser_type}_extension.zip"
      send_file path, :filename => "sample_#{browser_type}_extension.zip"
    end
  end

  def generate_extension
    if !params[:user_code].blank?
      @user_code = params[:user_code]
      foldername = Time.now.strftime("%d_%b_%Y_%H%M%S")
      browser_type = params[:browser_type]
      system("mkdir #{Rails.root}/public/user_extensions/#{browser_type}/#{foldername}")
      system("cp -r #{Rails.root}/public/user_extensions/#{browser_type}/#{browser_type}_extension/* #{Rails.root}/public/user_extensions/#{browser_type}/#{foldername}/")
      if browser_type == "firefox"
        modified_file = File.open("#{Rails.root}/public/user_extensions/firefox/#{foldername}/helloworld/locale/en-US/hello.dtd", 'r')
        sub_string = "This is a separate window!"
      elsif browser_type == "chrome"
        modified_file = File.open("#{Rails.root}/public/user_extensions/chrome/#{foldername}/Hello World/popup.html", 'r')
        sub_string =  "Hello World!"
      end
      aString = modified_file.read
      modified_file.close
      aString.gsub!(sub_string, @user_code.gsub!(/\<p\>/, '').gsub(/\<\/p\>/, ' '))
      if browser_type == "firefox"
        File.open("#{Rails.root}/public/user_extensions/firefox/#{foldername}/helloworld/locale/en-US/hello.dtd", "w") { |file| file << aString }
      elsif browser_type == "chrome"
        File.open("#{Rails.root}/public/user_extensions/chrome/#{foldername}/Hello World/popup.html", "w") { |file| file << aString }
      end
      path="#{Rails.root}/public/user_extensions/#{browser_type}/#{foldername}"
      compress(path)
      system("mv #{Rails.root}/public/user_extensions/#{browser_type}/#{foldername}/#{foldername}.zip #{Rails.root}/public/user_extensions/#{browser_type}/")
      system("rm -rf #{Rails.root}/public/user_extensions/#{browser_type}/#{foldername}/")
      if browser_type == "firefox"
        system("mv #{Rails.root}/public/user_extensions/#{browser_type}/#{foldername}.zip #{Rails.root}/public/user_extensions/#{browser_type}/#{foldername}.xpi")
        xpi_file_path = "#{Rails.root}/public/user_extensions/#{browser_type}/#{foldername}.xpi"
        send_file xpi_file_path, :filename => "Extension.xpi"
      elsif browser_type == "chrome"
        zip_file_path = "#{Rails.root}/public/user_extensions/#{browser_type}/#{foldername}.zip"
        send_file zip_file_path, :filename => "Extension.zip"
      end
    else
      redirect_to root_path
    end
  end

  def compress(path)
    path.sub!(%r[/$],'')
    archive = File.join(path,File.basename(path))+'.zip'
    FileUtils.rm archive, :force=>true

    Zip::ZipFile.open(archive, 'w') do |zipfile|
      Dir["#{path}/**/**"].reject{|f|f==archive}.each do |file|
        zipfile.add(file.sub(path+'/',''),file)
      end
    end
  end

end
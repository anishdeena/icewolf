class ApplicationController < ActionController::Base
  require 'db_constants.rb'
  require 'app_constants.rb'
  require 'error_codes.rb'
  require 'app_exception.rb'
  protect_from_forgery
  
end

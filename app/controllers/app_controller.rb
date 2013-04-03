class AppController < ApplicationController
  skip_before_filter :authenticate
  
  def loader
  end
end

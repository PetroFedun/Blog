class StaticPagesController < ApplicationController
  def help
    render 'static_pages/help'
  end

  def contact
    render 'static_pages/contact'
  end

  def about
    render 'static_pages/about'
  end 
end  

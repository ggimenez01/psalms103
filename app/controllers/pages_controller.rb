# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  def about
    @about = About.first
  end

  def contact
    @contact = Contact.first
  end
end

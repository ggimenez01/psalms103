class AboutsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @about = About.first
  end
  
  def edit
    @about = About.first
  end

  def update
    @about = About.first
    if @about.update(about_params)
      redirect_to about_path, notice: 'About updated successfully.'
    else
      render :edit
    end
  end

  private

  def about_params
    params.require(:about).permit(:title, :content)
  end
end

class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to front_page_path, notice: 'Contact created successfully.'
    else
      render :new
    end
  end

  def show
    # No need to find the contact, as it will be fetched in the before_action
  end

  def edit
    # No need to find the contact, as it will be fetched in the before_action
  end

  def update
    if @contact.update(contact_params)
      redirect_to front_page_path, notice: 'Contact updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to front_page_path, notice: 'Contact deleted successfully.'
  end

  private

  def set_contact
    @contact = Contact.first_or_create
  end

  def contact_params
    params.require(:contact).permit(:title, :address, :telephone_number, :email, :website)
  end
end

class ContactFormController < ApplicationController
  skip_before_action :require_authentication

  def new
    @contact_form = ContactForm.new
  end

  def create
    @contact_form = ContactForm.new(contact_form_params)
    @contact_form.request = request

    respond_to do |format|
      if @contact_form.deliver
        format.html do
          redirect_to new_contact_form_path, notice: 'Message sent successfully!'
        end
        format.json { render json: 'Message sent successfully!' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json do
          render json: @contact_form.errors, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def contact_form_params
    params.require(:contact_form).permit(:name, :email, :message, :nickname)
  end
end

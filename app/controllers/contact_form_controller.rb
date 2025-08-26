class ContactFormController < ApplicationController
  def new
    @contact_form = ContactForm.new
  end

  def create
    @contact_form = ContactForm.new(params[:contact_form])
    @contact_form.request = request

    respond_to do |format|
      if @contact_form.deliver
        format.html { redirect_to contact_path,
                      notice: "Message sent successfully!" }
        format.json { render json: "Message sent successfully!"}
      else
        format.html { render :new,
                      status: :unprocessable_entity }
        format.json { render json: @contact_form.errors,
                      status: :unprocessable_entity }
      end
    end
  end
end

class ContactsController < ApplicationController
  def new
    @form = ContactForm.new
  end

  def create
    @form = ContactForm.new(contact_params)
    if @form.valid?
      ContactMailer.with(form: @form).notify.deliver_now
      redirect_to contact_thanks_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def thanks
  end

  private
  def contact_params
    params.require(:contact_form).permit(:name, :email, :subject, :message)
  end
end

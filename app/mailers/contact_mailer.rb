class ContactMailer < ApplicationMailer
    default to: ENV.fetch("CONTACT_TO", "churoom.info@gmail.com"),
            from: ENV.fetch("CONTACT_FROM", "no-reply@churoom.app")

  def notify
    @form = params[:form]
    mail(
      subject: "【chuRoom お問い合わせ】#{@form.subject.presence || '件名なし'}",
      reply_to: @form.email
    )
  end
end

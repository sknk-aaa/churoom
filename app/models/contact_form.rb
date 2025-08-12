class ContactForm
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :name,    :string
    attribute :email,   :string
    attribute :subject, :string
    attribute :message, :string

    validates :name, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :subject, presence: true, length: { maximum: 50 }
    validates :message, presence: true, length: { maximum: 500 }
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id', inverse_of: :sender, dependent: :nullify
  has_many :received_messages,
           class_name: 'Message',
           foreign_key: 'receiver_id',
           inverse_of: :receiver,
           dependent: :nullify

  def renew_session!
    update!(session: SecureRandom.uuid, session_expires_at: Time.current + Session::DEFAULT_EXPIRATION)
  end
end

class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_one_attached :file

  validates :content, presence: true, unless: -> { file.attached? }
  validate  :file_size, if: -> { file.attached? }
  validate  :file_type, if: -> { file.attached? }

  def file_size
    errors.add(:file, 'Arquivo muito grande (máx. 5MB)') if file.byte_size > 5.megabytes
  end

  def file_type
    allowed_types = %w[image/jpeg image/png application/pdf]
    errors.add(:file, 'tipo de arquivo não permitido') unless allowed_types.include?(file.content_type)
  end
end

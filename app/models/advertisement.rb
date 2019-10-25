class Advertisement < ApplicationRecord
  validates :text, presence: true, length: { minimum: 10}
  validates :status, presence: true

  belongs_to :user, -> { where(role: :user) }

  extend Enumerize
  enumerize :status, in: [:draft, :new, :rejected, :approved, :published, :archived]
end

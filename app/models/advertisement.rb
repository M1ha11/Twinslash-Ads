class Advertisement < ApplicationRecord
  validates :text, presence: true, length: { minimum: 10}
  validates :name, presence: true

  belongs_to :user, -> { where(role: :user) }

  # extend Enumerize
  # enumerize :status, in: [:draft, :new, :rejected, :approved, :published, :archived]

  state_machine :state, initial: :draft do
    event :create_new do
      transition draft: :new
    end

    event :approve do
      transition new: :approved
    end

    event :reject do
      transition new: :rejected
    end

    event :pusblish do
      transition approved: :published
    end

    event :archive do
      transition published: :archived
    end
  end
end

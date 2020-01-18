class Advertisement < ApplicationRecord
  validates :text, presence: true, length: { minimum: 10}
  validates :name, presence: true
  validates :typ, length: {minimum: 4}, allow_blank: true

  belongs_to :user, -> { where(role: :user) }
  # has_many :images
  # accepts_nested_attributes_for :images, allow_destroy: true
  # belongs_to :type
  # accepts_nested_attributes_for :type, reject_if: :new_record?
  has_many_attached :images

  # extend Enumerize
  # enumerize :status, in: [:draft, :new, :rejected, :approved, :published, :archived]

  state_machine :state, initial: :draft do
    event :add_new do
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

    event :back_to_draft do
      transition archived: :draft
    end
  end

  def self.search(search)
    if search && state == 'published' && Advertisement.where('name like ?', "%#{search}%")
      where('name like ?', "%#{search}%")
    else
      all
    end
  end
end

class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy # if u destroy list, u destroy bookmarks
  has_many :movies, through: :bookmarks
  validates :name, presence: true
  validates :name, uniqueness: true
  validates_associated :bookmarks
  # validates :rating, numericality: { only_integer: true }
  # validates :rating, presence: true, inclusion: { in: 0..5 }

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :title, :overview ],
    using: {
      tsearch: { prefix: true }
    }
end

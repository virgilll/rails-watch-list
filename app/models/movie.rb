class Movie < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :lists, through: :bookmarks # basically a movie appears in many lists
  validates :title, presence: true
  validates :title, uniqueness: true
  validates :overview, presence: true

  include PgSearch::Model
  pg_search_scope :search_by_title_and_overview,
    against: [ :title, :overview ],
    using: {
      tsearch: { prefix: true }
    }
end

# through is just way to access the list/movie id in bookmarks since theyre not connected

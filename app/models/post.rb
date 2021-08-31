class Post < ApplicationRecord
  validate :title_validator, on: :title
  validates :title, presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
  validate :clickbait?

  BAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top \d/i,
    /Guess/i
  ]
  def clickbait?
    if BAIT_PATTERNS.none? { |pattern| pattern.match(title) }
      errors.add(:title, "must be clickbait")
    end
  end
end

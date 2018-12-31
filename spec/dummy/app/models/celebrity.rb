class Celebrity < ApplicationRecord
  is_audited

  validates :gender, numericality: { less_than: 3 }
end

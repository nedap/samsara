class Celebrity < ActiveRecord::Base
  is_audited

  validates :gender, numericality: { less_than: 3 }
end

class Agreement < ActiveRecord::Base

  validates :content, presence: true
end

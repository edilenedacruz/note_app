class Note < ApplicationRecord
  validates :topic, :content, presence: true
end

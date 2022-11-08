class Event < ApplicationRecord
    belongs_to :admin
    has_many :notifications, dependent: :destroy
end

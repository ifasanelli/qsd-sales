class Order < ApplicationRecord
  belongs_to :user
  belongs_to :customer

  enum status: { open: 0, approved: 4, cancelled: 8 }

  validates :cancellation_reason, presence: true, if: :cancelled?
end

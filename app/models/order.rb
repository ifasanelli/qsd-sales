class Order < ApplicationRecord
  belongs_to :user
  belongs_to :customer

  enum status: { open: 0, approved: 4, cancelled: 8 }

  validate :cancellation_has_reason, on: :update

  private

  def cancellation_has_reason
    if(self.cancelled? && cancellation_reason.empty?)
      errors.add(:cancellation_reason,
                 'Motivo de cancelamento não pode ficar em branco')
    end
  end
  
end

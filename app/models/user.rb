class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { seller: 0, admin: 5 }

  after_initialize :set_defaults

  private

  def set_defaults
    return self.role ||= :seller if new_record?
  end
end

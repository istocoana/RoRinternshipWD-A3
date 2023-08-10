class Order < ApplicationRecord
  belongs_to :user
  has_many  :order_items
  has_many  :products, through: :order_items

  validates :user_id, presence: true
  validates :order_date, presence: true
  validates :status, presence: true
  validate  :completed_order_date_validity

  enum status: {
    pending: 0,
    processing: 1,
    completed: 2
  }

  private

  def completed_order_date_validity
    if completed? && completed_order_date.blank?
      errors.add(:completed_order_date, "must be present for completed orders")
    end
  end

end

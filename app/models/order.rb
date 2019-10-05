class Order < ApplicationRecord
  belongs_to :gig, required: false
  belongs_to :request, required: false

  belongs_to :buyer, class_name: "User"
  belongs_to :seller, class_name: "User"

  has_many :reviews

  enum status: [:pending, :accepted, :rejected]
  validates :amount, :days, numericality: { only_integer: true, message: "数値のみ入力可能です"}
end

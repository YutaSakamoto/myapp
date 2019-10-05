class Offer < ApplicationRecord
  belongs_to :request
  belongs_to :user

  enum status: [:pending, :accepted, :rejected]
  validates :amount, :days, numericality: { only_integer: true, message: "数値で入力してください" }
end

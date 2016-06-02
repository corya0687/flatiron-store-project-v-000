class Item < ActiveRecord::Base
  belongs_to :category
  has_many :line_items
  has_many :carts, through: :cart_id

  def self.available_items
    all.where("inventory  > ?", 0)
  end
end

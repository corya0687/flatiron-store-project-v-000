class Cart < ActiveRecord::Base
belongs_to :user
has_many :orders
has_many :line_items
has_many :items, through: :line_items

  def total
    self.line_items.inject(0) do |sum, line_item|
      sum + line_item.item.price * line_item.quantity
    end
  end

  def add_item(item_id)
    if LineItem.exists?(item_id: item_id)
      line_item = LineItem.where(item_id: item_id)[0]
      line_item.quantity += line_item.quantity
      line_item
     else
      self.line_items.build(quantity: 1, cart_id: self.id, item_id: item_id)
    end
  end
end

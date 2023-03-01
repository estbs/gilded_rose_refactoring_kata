class AgedBrie < Item
  def initialize(name, sell_in, quality)
    super
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def process
    return unless item_attr_lower_than?(quality, 50)

    item_attr_lower_than?(sell_in, 0) ? increase_item_quality_in(1) : increase_item_quality_in(2)
  end

  private

  def item_attr_lower_than?(item_attr, amount)
    item_attr < amount
  end

  def increase_item_quality_in(amount_to_decrease)
    self.quality += amount_to_decrease
  end
end

class Sulfuras < Item
  def initialize(name, sell_in, quality)
    super
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def process
    increase_item_quality_in(1) if item_attr_lower_than?(quality, 50)
  end

  private

  def increase_item_quality_in(amount_to_decrease)
    self.quality += amount_to_decrease
  end

  def item_attr_lower_than?(item_attr, amount)
    item_attr < amount
  end
end

class Conjured < Item
  def initialize(name, sell_in, quality)
    super
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def process
    decrease_item_quality_in(2) if item_quality_more_than?(quality, 0)
  end

  private

  def decrease_item_quality_in(amount_to_decrease)
    self.quality -= amount_to_decrease if self.quality - amount_to_decrease >= 0
    0
  end

  def item_quality_more_than?(item_quality, quality)
    item_quality > quality
  end
end

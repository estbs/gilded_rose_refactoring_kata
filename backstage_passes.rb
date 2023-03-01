class BackstagePasses < Item
  def initialize(name, sell_in, quality)
    super
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def process
    increase_backstage_passes_quality
    decrease_item_quality_in(quality) if item_attr_lower_than?(sell_in, 0)
  end

  private

  def increase_backstage_passes_quality
    return unless item_attr_lower_than?(quality, 50)

    increase_item_quality_in(3) if sell_in_item_between(0, 6)
    increase_item_quality_in(2) if sell_in_item_between(5, 11)
    increase_item_quality_in(1) if item_attr_greather_than?(sell_in, 11)
  end

  def decrease_item_quality_in(amount_to_decrease)
    self.quality -= amount_to_decrease if self.quality - amount_to_decrease >= 0
    0
  end

  def item_attr_lower_than?(item_attr, amount)
    item_attr < amount
  end

  def increase_item_quality_in(amount_to_decrease)
    self.quality += amount_to_decrease
  end

  def sell_in_item_between(init, finish)
    item_attr_greather_than?(sell_in, init) && item_attr_lower_than?(sell_in, finish)
  end

  def item_attr_greather_than?(item_attr, amount)
    item_attr > amount
  end
end

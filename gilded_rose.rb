class GildedRose
  GENERAL_QUALITY_DECREASE = 1

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      decrease_item_sellin_in(item, 1) unless sulfuras_item?(item)
      proxy_item(item)
    end
  end

  private

  def sulfuras_item?(item)
    item.class.name.eql? 'Sulfuras'
  end

  def proxy_item(item)
    exists_item_class?(item) ? item.process : process_normal_item(item)
  end

  def exists_item_class?(item)
    %w[AgedBrie BackstagePasses Sulfuras Conjured].include? item.class.name
  end

  def process_normal_item(item)
    amount_to_decrease = item_attr_greather_than?(item.sell_in, 0) ? GENERAL_QUALITY_DECREASE : GENERAL_QUALITY_DECREASE * 2
    decrease_item_quality_in(item, amount_to_decrease) if item_quality_more_than?(item.quality, 0)
  end

  def name_item_eql_to?(item_name, name)
    item_name.eql? name
  end

  def item_quality_more_than?(item_quality, quality)
    item_quality > quality
  end

  def item_attr_greather_than?(item_attr, amount)
    item_attr > amount
  end

  def decrease_item_quality_in(item, amount_to_decrease)
    item.quality -= amount_to_decrease if item.quality - amount_to_decrease >= 0
    0
  end

  def decrease_item_sellin_in(item, amount_to_decrease)
    item.sell_in -= amount_to_decrease
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end

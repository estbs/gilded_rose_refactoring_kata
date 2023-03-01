class GildedRose
  GENERAL_QUALITY_DECREASE = 2

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      decrease_item_sellin_in(item, 1) unless name_item_eql_to?(item.name, 'Sulfuras, Hand of Ragnaros')
      proxy_item(item)
    end
  end

  private

  def proxy_item(item)
    case item.name
    when 'Aged Brie'
      process_aged_brie_item(item)
    when 'Backstage passes to a TAFKAL80ETC concert'
      process_backstage_passes_item(item)
    when 'Sulfuras, Hand of Ragnaros'
      process_sulfuras_item(item)
    when 'Conjured'
      decrease_item_quality_in(item, GENERAL_QUALITY_DECREASE * 2) if item_quality_more_than?(item.quality, 0)
    else
      decrease_item_quality_in(item, GENERAL_QUALITY_DECREASE) if item_quality_more_than?(item.quality, 0)
    end
  end

  def process_aged_brie_item(item)
    return unless item_attr_lower_than?(item.quality, 50)

    item_attr_lower_than?(item.sell_in, 0) ? increase_item_quality_in(item, 1) : increase_item_quality_in(item, 2)
  end

  def process_backstage_passes_item(item)
    increase_backstage_passes_quality(item)
    decrease_item_quality_in(item, item.quality) if item_attr_lower_than?(item.sell_in, 0)
  end

  def increase_backstage_passes_quality(item)
    return unless item_attr_lower_than?(item.quality, 50)

    increase_item_quality_in(item, 3) if sell_in_item_between(item, 0, 6)
    increase_item_quality_in(item, 2) if sell_in_item_between(item, 5, 11)
    increase_item_quality_in(item, 1) if item_attr_greather_than?(item.sell_in, 11)
  end

  def sell_in_item_between(item, init, finish)
    item_attr_greather_than?(item.sell_in, init) && item_attr_lower_than?(item.sell_in, finish)
  end

  def process_sulfuras_item(item)
    increase_item_quality_in(item, 1) if item_attr_lower_than?(item.quality, 50)
  end

  def name_item_eql_to?(item_name, name)
    item_name.eql? name
  end

  def item_quality_more_than?(item_quality, quality)
    item_quality > quality
  end

  def item_attr_lower_than?(item_attr, amount)
    item_attr < amount
  end

  def item_attr_greather_than?(item_attr, amount)
    item_attr > amount
  end

  def decrease_item_quality_in(item, amount_to_decrease)
    item.quality -= amount_to_decrease
  end

  def decrease_item_sellin_in(item, amount_to_decrease)
    item.sell_in -= amount_to_decrease
  end

  def increase_item_quality_in(item, amount_to_decrease)
    item.quality += amount_to_decrease
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

class AgedBrie < Item
  def initialize(item)
    super(item.name, item.sell_in, item.quality)
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
    puts "quality: #{self.quality}"
    self.quality += amount_to_decrease
    puts "self: #{self}"
    puts "super: #{self.quality.super}"
  end
end

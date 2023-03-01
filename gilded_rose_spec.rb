require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      items = [Item.new('foo', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].name).to eq 'foo'
    end

    it 'Degrade Quality twice as fast after sell-in date' do
      items = [Item.new('foo_test1', 0, 2)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end

    it 'Never update quality to negative amount' do
      items = [Item.new('foo_test2', 0, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to be >= 0
    end

    it 'never update quality more than 50' do
      items = [Item.new('Aged Brie', 0, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to be <= 50
    end

    describe 'Aged Brie items' do
      it 'Increases the quality the older it gets' do
        items = [Item.new('Aged Brie', 0, 1)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to be > 1
      end
    end

    describe 'Sulfuras, Hand of Ragnaros items' do
      it 'Never is sold or change the quality' do
        items = [Item.new('Sulfuras, Hand of Ragnaros', 80, 50)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 50
      end

      it 'Never is sold or change the quality' do
        items = [Item.new('Sulfuras, Hand of Ragnaros', 50, 80)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 80
      end
    end

    describe 'Backstage passes to a TAFKAL80ETC concert passes items' do
      it 'Quality increases the quality until the sell-in date' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 15, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 21
      end

      it 'Quality increases in 2 the quality when there from 10 days to 6 days' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 8, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 22
      end

      it 'Quality increases in 3 the quality when there from 5 days to 0 days' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 3, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 23
      end

      it 'Quality drop to 0 after the concert' do
        items = [Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 20)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 0
      end
    end

    describe 'Conjured items' do
      it 'Quality degrades twice as fast as normal items' do
        items = [Item.new('Conjured', 2, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].quality).to eq 6
      end
    end
  end
end

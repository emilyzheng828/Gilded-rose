require File.join(File.dirname(__FILE__), 'original')

describe Item do 
  it 'has name, sell_in and quality' do
    item = Item.new('normal', 9, 8)
    expect(item.name).to eq 'normal'
    expect(item.sell_in).to eq 9
    expect(item.quality).to eq 8
  end

  describe '#to_s' do
    it 'describes the item' do
      item = Item.new('normal', 9,8)
      expect(item.to_s).to eq 'normal, 9, 8'
    end
  end
end

describe GildedRose do
  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("normal", 0, 0)]
      GildedRose.new(items).update_quality

      expect(items[0].name).to eq "normal"
    end

    it 'lowers the sell_in amount by 1' do
      item = Item.new('normal', 10, 10)
      items = [item]
      GildedRose.new(items).update_quality()

      expect(items[0].sell_in).to eq 9
    end

    it 'lower the quality value by 1' do
      item = Item.new('normal', 9, 9)
      items = [item]
      GildedRose.new(items).update_quality()

      expect(items[0].quality).to eq 8
    end
  end

  context 'sell_in is negative' do
    it 'degrades the quality twice as fast' do
      item = Item.new('normal', -1, 10)
      items = [item]
      GildedRose.new(items).update_quality()

      expect(items[0].quality).to eq 8
    end
  end

  context 'when quality is 0' do
    it 'does not change value' do
      item = Item.new('normal', 1, 0)
      GildedRose.new([item]).update_quality()

      expect(item.quality).to eq 0
    end
  end

  context "when 'Aged Brie'" do
    it 'increase quality by 1' do
      item = Item.new('Aged Brie', 1, 1)
      GildedRose.new([item]).update_quality()

      expect(item.quality).to eq 2
    end

    context "when quality reaches 50" do
      it 'does not change' do
        item = Item.new('Aged Brie', 2, 50)
        GildedRose.new([item]).update_quality()

        expect(item.quality).to eq 50
      end
    end

    context "once sell by date has passed" do
      it 'the quality decreases twice as fast' do
        item = Item.new('Aged Brie', -1, 10)
        GildedRose.new([item]).update_quality()

        expect(item.quality).to eq 12
      end
    end
  end

  context "When name is Sulfuras" do
    it 'never has to be sold or decreases in quality and always be 80' do
      item = Item.new('Sulfuras, Hand of Ragnaros',0, 80)
      GildedRose.new([item]).update_quality()

      expect(item.quality).to eq 80
    end
  end

  context "Backstage passes" do
    it 'increases quality as Sellin value approaches' do
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', 10, 20)
      GildedRose.new([item]).update_quality()
      
      expect(item.quality).to eq 22
    end
    
    it 'increases quality as Sellin value approaches' do
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', 6, 20)
      GildedRose.new([item]).update_quality()
      
      expect(item.quality).to eq 22
    end
    it 'increases quality as Sellin value approaches' do
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', 4, 20)
      GildedRose.new([item]).update_quality()
      
      expect(item.quality).to eq 23
    end

    it 'increases quality as Sellin value approaches' do
      item = Item.new('Backstage passes to a TAFKAL80ETC concert', 0, 20)
      GildedRose.new([item]).update_quality()
      
      expect(item.quality).to eq 0
    end
  end


end

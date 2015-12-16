class GildedRose

  def initialize(items)
    @items = items
  end

  class NormalItemQualityChangeCalculator
    def change
      -1
    end
  end

  class BrieQualityChangeCalculator
    def change
      1
    end
  end

  class BackstagePassQualityChangeCalculator
    attr_accessor :item

    def initialize(item)
      @item = item
        puts "heloo1"
    end

    def change
        puts "heloo2"
        newQuality = 0
      if item.sell_in < 11
        puts "heloo3"
        if item.quality < 50
          puts "hello4"
          newQuality = 2
        end
      end
      puts "hello5"
      if item.sell_in < 6
        if item.quality < 50
          newQuality = 2
        end
      end
      newQuality
    end
  end

  def update_quality()
    @items.each do |item|
      quality_change_calculator = if item.name == 'Aged Brie'
        BrieQualityChangeCalculator.new
      elsif item.name =~ /^Backstage pass/
        puts "heloo"
        BackstagePassQualityChangeCalculator.new(item)
      else
        NormalItemQualityChangeCalculator.new
      end
      
      # eventually, we'll be able to just call:
      # item.quality += quality_change_calculator.change

      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality += quality_change_calculator.change
          end
        end
      else
        if item.quality < 50
          item.quality += quality_change_calculator.change
        end
      end

      update_sell_in(item)
  
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

  def update_sell_in(item)
    if item.name != "Sulfuras, Hand of Ragnaros"
      item.sell_in = item.sell_in - 1
    end
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

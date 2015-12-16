class GildedRose

  def initialize(items)
    @items = items
  end

  def normal_tick(item)
    item.quality -= 1
  end
  
  def normal_sellin(item)
    item.sell_in -= 1
  end
  
  def brie_tick(item)
    item.quality += 1
  end

  def sulfuras_tick(item)
    item.quality = item.quality - item.quality
  end

  def update_quality()
    @items.each do |item|
#      item.name case 
#    when item.name == "Aged Brie" 
#      brie_tick(item)
#      normal_sellin(item)
#    when item.name == "Backstage passes to a TAFKAL80ETC concert"
#      
#    else normal_tick(item)
#
#    end
#
      if item.name != "Aged Brie" and item.name != "Backstage passes to a TAFKAL80ETC concert"

        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            normal_tick(item)
          end
        end
      else

        if item.quality < 50
          brie_tick(item)
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              brie_tick(item) if item.quality < 50
            end
            if item.sell_in < 6
              brie_tick(item) if item.quality < 50
            end
          end
        end
      end

      if item.name != "Sulfuras, Hand of Ragnaros"
        normal_sellin(item)
      end

      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            
            if item.quality > 0
              if item.name != "Sulfuras, Hand of Ragnaros"
                normal_tick(item)
              end
            end

          else
            sulfuras_tick(item)
          end

        else
          if item.quality < 50
            brie_tick(item)
          end
        end

      end
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

require './item.rb'

class GildedRose

  attr_reader :items

  @items = []

  def initialize
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << Item.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)
  end

  def find(name)
    items.detect{ |item| item.name == name }
  end

  def brie?(item)
    item.name == "Aged Brie"
  end

  def backstage_pass?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def update_quality
    items.each do |item|
      if !brie?(item) && !backstage_pass?(item)
        decreases_quality(item, 1)
      else
        increase_quality(item, 1)
        if backstage_pass?(item)
          if item.sell_in < 11
            increase_quality(item, 1)
          end
          if item.sell_in < 6
            increase_quality(item, 1)
          end
        end
      end

      update_sell_in(item)

      if item.sell_in < 0
        if !brie?(item)
          if !backstage_pass?(item)
            decreases_quality(item, 1)
          else
            decreases_quality(item, item.quality)
          end
        else
          increase_quality(item, 1)
        end
      end
    end
  end

  def update_sell_in(item)
    unless sulfuras? item
      item.sell_in = item.sell_in - 1;
    end
  end

  def increase_quality(item, amount)
    if item.quality < 50
      item.quality = item.quality + amount
    end
  end

  def decreases_quality(item, amount)
    if item.quality > 0
      if !sulfuras?(item)
        item.quality = item.quality - amount
      end
    end
  end
end

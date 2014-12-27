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

  def passed_sell_in?(item)
    item.sell_in < 0
  end

  def update_quality
    items.each do |item|
      next if sulfuras?(item)

      update_sell_in(item)

      if brie?(item)
        increase_quality(item, 1)
      elsif backstage_pass?(item)
        increase_quality(item, 1)
        if item.sell_in < 10
          increase_quality(item, 1)
        end
        if item.sell_in < 5
          increase_quality(item, 1)
        end
      else
        decreases_quality(item, 1)
      end

      if passed_sell_in?(item)
        if brie?(item)
          increase_quality(item, 1)
        elsif backstage_pass?(item)
          decreases_quality(item, item.quality)
        else
          decreases_quality(item, 1)
        end
      end
    end
  end

  def update_sell_in(item)
    item.sell_in = item.sell_in - 1;
  end

  def increase_quality(item, amount)
    if item.quality < 50
      item.quality = item.quality + amount
    end
  end

  def decreases_quality(item, amount)
    if item.quality > 0
      item.quality = item.quality - amount
    end
  end
end

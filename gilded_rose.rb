require './item.rb'
require './quality_updater.rb'

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

  def add(item)
    items << item
  end

  def update_quality
    items.each do |item|
      quality_updater = QualityUpdater.new
      quality_updater.update_quality item
    end
  end
end

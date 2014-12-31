require './item.rb'

class QualityUpdater
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def brie?
    item.name == "Aged Brie"
  end

  def backstage_pass?
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def sulfuras?
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def conjured?
    item.name =~ /Conjured/
  end

  def passed_sell_in?
    item.sell_in < 0
  end

  def update_quality
    return if sulfuras?

    update_sell_in

    if brie?
      update_brie_quality
    elsif backstage_pass?
      update_backstage_quality
    elsif conjured?
      update_conjured_quality
    else
      update_default_quality
    end
  end

  def update_brie_quality
    if passed_sell_in?
      increase_quality 2
    else
      increase_quality 1
    end
  end

  def update_conjured_quality
    if passed_sell_in?
      decreases_quality 4
    else
      decreases_quality 2
    end
  end

  def update_backstage_quality
    if passed_sell_in?
      decreases_quality item.quality
    else
      if item.sell_in < 5
        increase_quality 3
      elsif item.sell_in < 10
        increase_quality 2
      else
        increase_quality 1
      end
    end
  end

  def update_default_quality
    if passed_sell_in?
      decreases_quality 2
    else
      decreases_quality 1
    end
  end

  def update_sell_in
    item.sell_in = item.sell_in - 1;
  end

  def increase_quality amount
    if item.quality < 50
      item.quality = item.quality + amount
    end
  end

  def decreases_quality amount
    if item.quality > 0
      item.quality = item.quality - amount
    end
  end
end

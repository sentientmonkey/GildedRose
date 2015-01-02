class ItemQualityUpdater
  attr_reader :item

  def initialize(item)
    @item = item
  end

  def update_quality
    update_sell_in

    if passed_sell_in?
      decreases_quality 2
    else
      decreases_quality 1
    end
  end

  private

  def passed_sell_in?
    item.sell_in < 0
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

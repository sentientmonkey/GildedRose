require './item_quality_updater.rb'

class BrieQualityUpdater < ItemQualityUpdater
  def update_quality
    update_sell_in

    if passed_sell_in?
      increase_quality 2
    else
      increase_quality 1
    end
  end
end

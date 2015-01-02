require './quality_updater.rb'

class BackstagePassQualityUpdater < QualityUpdater
  def update_quality
    update_sell_in

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
end

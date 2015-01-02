require './quality_updater.rb'

class ConjuredItemUpdater < QualityUpdater
  def update_quality
    update_sell_in

    if passed_sell_in?
      decreases_quality 4
    else
      decreases_quality 2
    end
  end
end

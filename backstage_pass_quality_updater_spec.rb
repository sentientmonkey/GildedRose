require './backstage_pass_quality_updater.rb'
require './spec_helper.rb'

describe BackstagePassQualityUpdater do
  let(:backstage_passes) do
    Item.new "Backstage passes to a TAFKAL80ETC concert", 15, 20
  end

  let(:backstage_pass_updater) do
    BackstagePassQualityUpdater.new backstage_passes
  end

  it "backstage passsess increase, then drops to zero" do
    quality = backstage_passes.quality
    5.times do
      backstage_pass_updater.update_quality
      quality += 1
      backstage_passes.quality.must_equal quality
    end
    5.times do
      backstage_pass_updater.update_quality
      quality += 2
      backstage_passes.quality.must_equal quality
    end
    5.times do
      backstage_pass_updater.update_quality
      quality += 3
      backstage_passes.quality.must_equal quality
    end
    backstage_pass_updater.update_quality
    backstage_passes.quality.must_equal 0
  end

end

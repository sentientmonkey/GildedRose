require './sulfuras_quality_updater.rb'
require 'minitest/autorun'
require 'minitest/pride'

describe SulfurasQualityUpdater do
  let(:sulfuras) do
    Item.new "Sulfuras, Hand of Ragnaros", 0, 80
  end

  let(:sulfuras_updater) do
    SulfurasQualityUpdater.new sulfuras
  end

  it "sulfuras never changes quality or sell_in" do
    sulfuras.quality.must_equal 80
    sulfuras.sell_in.must_equal 0
    sulfuras_updater.update_quality
    sulfuras.quality.must_equal 80
    sulfuras.sell_in.must_equal 0
  end
end

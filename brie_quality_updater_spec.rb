require './spec_helper.rb'

describe BrieQualityUpdater do
  let(:aged_brie) do
    Item.new "Aged Brie", 2, 0
  end

  let(:aged_brie_updater) do
    BrieQualityUpdater.new aged_brie
  end

  it "should update brie with age" do
    quality = aged_brie.quality
    aged_brie_updater.update_quality
    aged_brie.quality.must_equal quality+1
  end

  it "should never increase quailty passed 50" do
    48.times { aged_brie_updater.update_quality }
    aged_brie.quality.must_equal 50
    aged_brie_updater.update_quality
    aged_brie.quality.must_equal 50
  end
end

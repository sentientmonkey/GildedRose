require './spec_helper.rb'

describe ConjuredItemUpdater do
  let(:conjured_item) do
    Item.new "Conjured Mana Cake", 3, 6
  end

  let(:conjured_item_updater) do
    ConjuredItemUpdater.new conjured_item
  end

  let(:new_conjured_item) do
    Item.new "Conjured Lava Cake", 5, 40
  end

  let(:new_conjured_item_updater) do
    ConjuredItemUpdater.new new_conjured_item
  end

  it "conjured items decay twice as fast" do
    quality = conjured_item.quality
    3.times do
      conjured_item_updater.update_quality
      quality -= 2
      conjured_item.quality.must_equal quality
    end
    conjured_item_updater.update_quality
    conjured_item.quality.must_equal 0
  end

  it "a new conjured item decays twice as fast" do
    quality = new_conjured_item.quality
    5.times do
      new_conjured_item_updater.update_quality
      quality -= 2
      new_conjured_item.quality.must_equal quality
    end
    new_conjured_item_updater.update_quality
    new_conjured_item.quality.must_equal quality-4
  end
end

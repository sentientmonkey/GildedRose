require './quality_updater.rb'
require 'minitest/autorun'
require 'minitest/pride'

describe QualityUpdater do

  let(:subject) do
    QualityUpdater
  end

  let(:default_item) do
    Item.new "Default Item", 10, 20
  end

  let(:default_item_updater) do
    subject.new default_item
  end

  let(:aged_brie) do
    Item.new "Aged Brie", 2, 0
  end

  let(:aged_brie_updater) do
    subject.new aged_brie
  end

  let(:sulfuras) do
    Item.new "Sulfuras, Hand of Ragnaros", 0, 80
  end

  let(:sulfuras_updater) do
    subject.new sulfuras
  end

  let(:backstage_passes) do
    Item.new "Backstage passes to a TAFKAL80ETC concert", 15, 20
  end

  let(:backstage_pass_updater) do
    subject.new backstage_passes
  end

  let(:conjured_item) do
    Item.new "Conjured Mana Cake", 3, 6
  end

  let(:conjured_item_updater) do
    subject.new conjured_item
  end

  let(:new_conjured_item) do
    Item.new "Conjured Lava Cake", 5, 40
  end

  let(:new_conjured_item_updater) do
    subject.new new_conjured_item
  end

  it "should update default quality" do
    quality = default_item.quality
    default_item.sell_in.times do
      default_item_updater.update_quality
      quality -= 1
      default_item.quality.must_equal quality
    end
  end

  it "should lower default quailty twice as fast after sell in" do
    default_item.sell_in.times { default_item_updater.update_quality }
    quality = default_item.quality
    default_item_updater.update_quality
    default_item.quality.must_equal quality-2
  end

  it "should never negate quantity" do
    20.times { default_item_updater.update_quality }
    default_item.quality.must_equal 0
    default_item_updater.update_quality
    default_item.quality.must_equal 0
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

  it "sulfuras never changes quality or sell_in" do
    sulfuras.quality.must_equal 80
    sulfuras.sell_in.must_equal 0
    sulfuras_updater.update_quality
    sulfuras.quality.must_equal 80
    sulfuras.sell_in.must_equal 0
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

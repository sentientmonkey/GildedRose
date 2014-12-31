require './quality_updater.rb'
require 'minitest/autorun'
require 'minitest/pride'

describe QualityUpdater do

  let(:subject) do
    QualityUpdater.new
  end

  let(:default_item) do
    Item.new "Default Item", 10, 20
  end

  let(:aged_brie) do
    Item.new "Aged Brie", 2, 0
  end

  let(:sulfuras) do
    Item.new "Sulfuras, Hand of Ragnaros", 0, 80
  end

  let(:backstage_passes) do
    Item.new "Backstage passes to a TAFKAL80ETC concert", 15, 20
  end

  let(:conjured_item) do
    Item.new "Conjured Mana Cake", 3, 6
  end

  let(:new_conjured_item) do
    Item.new "Conjured Lava Cake", 5, 40
  end

  it "should update default quality" do
    quality = default_item.quality
    default_item.sell_in.times do
      subject.update_quality default_item
      quality -= 1
      default_item.quality.must_equal quality
    end
  end

  it "should lower default quailty twice as fast after sell in" do
    default_item.sell_in.times { subject.update_quality default_item }
    quality = default_item.quality
    subject.update_quality default_item
    default_item.quality.must_equal quality-2
  end

  it "should never negate quantity" do
    20.times { subject.update_quality default_item }
    default_item.quality.must_equal 0
    subject.update_quality default_item
    default_item.quality.must_equal 0
  end

  it "should update brie with age" do
    quality = aged_brie.quality
    subject.update_quality aged_brie
    aged_brie.quality.must_equal quality+1
  end

  it "should never increase quailty passed 50" do
    48.times { subject.update_quality aged_brie }
    aged_brie.quality.must_equal 50
    subject.update_quality aged_brie
    aged_brie.quality.must_equal 50
  end

  it "sulfuras never changes quality or sell_in" do
    sulfuras.quality.must_equal 80
    sulfuras.sell_in.must_equal 0
    subject.update_quality sulfuras
    sulfuras.quality.must_equal 80
    sulfuras.sell_in.must_equal 0
  end

  it "backstage passsess increase, then drops to zero" do
    quality = backstage_passes.quality
    5.times do
      subject.update_quality backstage_passes
      quality += 1
      backstage_passes.quality.must_equal quality
    end
    5.times do
      subject.update_quality backstage_passes
      quality += 2
      backstage_passes.quality.must_equal quality
    end
    5.times do
      subject.update_quality backstage_passes
      quality += 3
      backstage_passes.quality.must_equal quality
    end
    subject.update_quality backstage_passes
    backstage_passes.quality.must_equal 0
  end

  it "conjured items decay twice as fast" do
    quality = conjured_item.quality
    3.times do
      subject.update_quality conjured_item
      quality -= 2
      conjured_item.quality.must_equal quality
    end
    subject.update_quality conjured_item
    conjured_item.quality.must_equal 0
  end

  it "a new conjured item decays twice as fast" do
    quality = new_conjured_item.quality
    5.times do
      subject.update_quality new_conjured_item
      quality -= 2
      new_conjured_item.quality.must_equal quality
    end
    subject.update_quality new_conjured_item
    new_conjured_item.quality.must_equal quality-4
  end
end

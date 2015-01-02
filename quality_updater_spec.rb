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
end

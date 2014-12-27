require './gilded_rose.rb'
require "minitest/autorun"
require "minitest/pride"

describe GildedRose do

  let(:subject) do
    GildedRose.new
  end

  def dexterity_vest
    subject.find "+5 Dexterity Vest"
  end

  def aged_brie
    subject.find "Aged Brie"
  end

  def sulfuras
    subject.find "Sulfuras, Hand of Ragnaros"
  end

  def backstage_passes
    subject.find "Backstage passes to a TAFKAL80ETC concert"
  end

  def conjured_item
    subject.find "Conjured Mana Cake"
  end

  def new_item_name
    "Nachos of Awesome"
  end

  let(:new_item) do
    Item.new new_item_name, 5, 10
  end

  let(:new_conjured_item) do
    item = Item.new "Conjured Lava Cake", 5, 40
    subject.add item
    item
  end

  it "should start with 6 items" do
    subject.items.size.must_equal 6
  end

  it "should end with 6 items" do
    subject.update_quality
    subject.items.size.must_equal 6
  end

  it "should find an item by name" do
    item = subject.find "+5 Dexterity Vest"
    item.wont_be_nil
  end

  it "dexerity vest should start with quality 20" do
    dexterity_vest.quality.must_equal 20
  end

  it "dexterity vest should start with sell in 10" do
    dexterity_vest.sell_in.must_equal 10
  end

  it "update_quality should lower value by one until sell in" do
    quality = dexterity_vest.quality
    dexterity_vest.sell_in.times do
      subject.update_quality
      quality -= 1
      dexterity_vest.quality.must_equal quality
    end
  end

  it "update_quality lowers twice as fast after sell in" do
    dexterity_vest.sell_in.times { subject.update_quality }
    quality = dexterity_vest.quality
    subject.update_quality
    dexterity_vest.quality.must_equal quality-2
  end

  it "update_quality never negates quantity" do
    15.times { subject.update_quality }
    dexterity_vest.quality.must_equal 0
    subject.update_quality
    dexterity_vest.quality.must_equal 0
  end

  it "aged brie improved with age" do
    quality = aged_brie.quality
    subject.update_quality
    aged_brie.quality.must_equal quality+1
  end

  it "quality can never exceed 50" do
    48.times { subject.update_quality }
    aged_brie.quality.must_equal 50
    subject.update_quality
    aged_brie.quality.must_equal 50
  end

  it "sulfuras never changes quality or sell_in" do
    sulfuras.quality.must_equal 80
    sulfuras.sell_in.must_equal 0
    subject.update_quality
    sulfuras.quality.must_equal 80
    sulfuras.sell_in.must_equal 0
  end

  it "backstage passsess increase, then drops to zero" do
    quality = backstage_passes.quality
    5.times do
      subject.update_quality
      quality += 1
      backstage_passes.quality.must_equal quality
    end
    5.times do
      subject.update_quality
      quality += 2
      backstage_passes.quality.must_equal quality
    end
    5.times do
      subject.update_quality
      quality += 3
      backstage_passes.quality.must_equal quality
    end
    subject.update_quality
    backstage_passes.quality.must_equal 0
  end

  it "conjured items decay twice as fast" do
    quality = conjured_item.quality
    3.times do
      subject.update_quality
      quality -= 2
      conjured_item.quality.must_equal quality
    end
    subject.update_quality
    conjured_item.quality.must_equal 0
  end

  it "can add a new item" do
    subject.add new_item
    result = subject.find new_item_name
    result.wont_be_nil
    result.name.must_equal new_item_name
  end

  it "a new conjured item decays twice as fast" do
    quality = new_conjured_item.quality
    5.times do
      subject.update_quality
      quality -= 2
      new_conjured_item.quality.must_equal quality
    end
    subject.update_quality
    new_conjured_item.quality.must_equal quality-4
  end
end

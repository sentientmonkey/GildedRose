require './spec_helper.rb'

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

  it "update_quality should udpate item qualities" do
    quality = dexterity_vest.quality
    dexterity_vest.sell_in.times do
      subject.update_quality
      quality -= 1
      dexterity_vest.quality.must_equal quality
    end
  end

  it "can add a new item" do
    subject.add new_item
    result = subject.find new_item_name
    result.wont_be_nil
    result.name.must_equal new_item_name
  end

end

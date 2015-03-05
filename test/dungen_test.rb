require "minitest/spec"
require "minitest/autorun"
require_relative "../lib/dungen"

describe Dungen do
  before do
    @dungen = Dungen.new
  end

  it "gens a room of set length and width" do
    five_by_three = [[" ", " ", " ", " ", " "], [" ", " ", " ", " ", " "], [" ", " ", " ", " ", " "]]
    assert_equal five_by_three, @dungen.room(5,3)
  end

  it "gens multiple rooms for given count" do
    assert_equal 3, @dungen.rooms(3).count
  end

  it "generates a solid layer of specified size and width" do
    five_by_three = [["#", "#", "#", "#", "#"], ["#", "#", "#", "#", "#"], ["#", "#", "#", "#", "#"]]
    assert_equal five_by_three, @dungen.layer(5,3)
  end

  it "carves a room from a layer" do
    layer = @dungen.layer(20, 20)
    room = @dungen.room(5,3)
    @dungen.carve(room, layer)
    #puts @dungen.format(layer)
  end

  it "carves multiple rooms" do
    layer = @dungen.layer(40, 20)
    room1 = @dungen.room(5,3)
    room2 = @dungen.room(6,4)
    @dungen.carve(room1, layer)
    @dungen.carve(room2, layer)
    #puts @dungen.format(layer)
  end

  it "carves individual spaces" do
    layer = @dungen.layer(40, 20)
    assert_equal "#", layer[0][0]
    @dungen.carve_space(0,0,layer)
    assert_equal " ", layer[0][0]
  end

  it "carves spaces sequentially" do
    3.times do
      puts "\n\n"
      layer = @dungen.layer(60, 45)
      puts "layer width: #{layer.first.length}"
      puts "layer height: #{layer.length}"
      @dungen.carve_path(800, layer)
      puts @dungen.format(layer)
    end
  end
end

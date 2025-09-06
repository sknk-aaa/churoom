# test/models/occupancy_test.rb
require "test_helper"

class OccupancyTest < ActiveSupport::TestCase
  test "正しい属性で有効か" do
    o = Occupancy.new(day: "Mon", time: 1, number: "3S01")
    assert o.valid?
  end

  test "空の属性で無効か" do
    o = Occupancy.new
    assert o.invalid?
    assert_includes o.errors[:day], "を入力してください"
    assert_includes o.errors[:time], "を入力してください"
    assert_includes o.errors[:number], "を入力してください"
  end

  test "曜日の値が無効な場合" do
    o = Occupancy.new(day: "Foo", time: 1, number: "3S01")
    assert o.invalid?
    assert_includes o.errors[:day], "は一覧にありません"
  end

  test "時間の値が無効な場合" do
    o = Occupancy.new(day: "Mon", time: 0, number: "3S01")
    assert o.invalid?
    assert_includes o.errors[:time], "は1以上の値にしてください"

    o.time = 6
    assert o.invalid?
    assert_includes o.errors[:time], "は一覧にありません"

    o.time = 2.5
    assert o.invalid?
    assert_includes o.errors[:time], "は整数でなければなりません"
  end

  test "一意性の検証" do
    Occupancy.create!(day: "Mon", time: 1, number: "3S01")
    dup = Occupancy.new(day: "Mon", time: 1, number: "3S01")
    assert dup.invalid?
    assert_includes dup.errors[:number], "はすでに存在します"
  end
end

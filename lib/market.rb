require 'date'

class Market
  attr_reader :name, :vendors
  
  def initialize(name)
    @name = name
    @vendors = []
  end
  
  def add_vendor(vendor)
    @vendors << vendor
  end
  
  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end
  
  def vendors_that_sell(item)
    @vendors.select {|vendor| vendor.check_stock(item) > 0}
  end
  
  def inventory_list
    list = []
    @vendors.each do |vendor|
      list << vendor.inventory.keys
    end
    list.flatten.uniq
  end
  
  def total_item(item)
    quantity_available = 0
    @vendors.each do |vendor|
      quantity_available += vendor.check_stock(item)
    end
    quantity_available
  end
  
  def total_inventory
    list = inventory_list
    inventory_hash = Hash.new
    list.each do |item|
      inventory_hash[item] = {quantity: total_item(item),
      vendors: vendors_that_sell(item)}
    end
    inventory_hash
  end
  
  def overstocked_items
    total_inventory.select do |item, details|
      details[:quantity] > 50 && details[:vendors].count > 1
    end.keys
  end
  
  def sorted_item_list
    inventory_list.map {|item| item.name}.sort
  end
  
  def sell(item, quantity)
    return false if !total_inventory.include?(item) || total_inventory[item][:quantity] < quantity
    total_inventory[item][:vendors].each do |vendor|
      sold = [quantity, vendor.check_stock(item)].min
      quantity -= sold
      vendor.sale(item, sold)
    end
    true
  end
  
  def self.date
    current_date = Date.today.strftime("%d/%m/%Y")
    market = Market.new(current_date)
    Date.today.strftime("%d/%m/%Y")
  end
end













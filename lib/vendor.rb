class Vendor
  attr_reader :name, :inventory
  
  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end
  
  def check_stock(item)
    @inventory[item]
  end
  
  def stock(item, quantity)
    @inventory[item] += quantity
  end
  
  def potential_revenue
    total_potential_revenue = 0
    @inventory.each do |item, quantity|
      total_potential_revenue += (item.price * quantity)
    end
    total_potential_revenue
  end
  
  def sale(item, quantity)
    @inventory[item] -= quantity
  end
end
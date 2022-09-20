require 'rspec'
require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.describe Market do
  let(:market) {Market.new("South Pearl Street Farmers Market")}
  let(:vendor1) {Vendor.new("Rocky Mountain Fresh")}
  let(:vendor2) {Vendor.new("Ba-Nom-a-Nom")}
  let(:vendor3) {Vendor.new("Palisade Peach Shack")}
  let(:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}
  let(:item3) {Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})}
  let(:item4) {Item.new({name: "Banana Nice Cream", price: "$4.25"})}
  
  context 'initialize' do
    it "exists" do
      expect(market).to be_a Market
    end
    
    it "has readable attributes" do
      expect(market.name).to eq("South Pearl Street Farmers Market")
      expect(market.vendors).to eq([])
    end
  end
  
  context "behavior" do
    it "#add_vendor adds a vendor to the array of Vendors" do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      result = [vendor1, vendor2, vendor3]
      
      expect(market.vendors).to eq(result)
    end
    
    it "#vendor_names returns array of vendor names" do
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      result = [vendor1.name, vendor2.name, vendor3.name]
      
      expect(market.vendor_names).to eq(result)
    end
    
    it "#vendors_that_sell returns array of Vendors that sell the provided item" do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      
      expect(market.vendors_that_sell(item1)).to eq([vendor1, vendor3])
      expect(market.vendors_that_sell(item4)).to eq([vendor2])
    end
    
    it "#inventory_list returns an array of inventory Items available" do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)
      vendor3.stock(item3, 10)
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      result = [item1, item2, item4, item3]
      
      expect(market.inventory_list).to eq(result)
    end
    
    it "#total_item returns an integer of the total inventory Items available
    across all vendors for a given Item" do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)
      vendor3.stock(item3, 10)
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      
      expect(market.total_item(item1)).to eq(100)
      expect(market.total_item(item3)).to eq(35)
    end
    
    it "#total_inventory returns a hash with items as keys, and a sub-hash
    as values; the sub hash kays 'quantity' and 'vendors' as keys, and the total quantity
    and array of vendors as respective values" do
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)
    vendor3.stock(item1, 65)
    vendor3.stock(item3, 10)
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)
    
    result = {
      item1 => {
        quantity: 100,
        vendors: [vendor1, vendor3]
      },
      item2 => {
        quantity: 7,
        vendors: [vendor1]
      },
      item4 => {
        quantity: 50,
        vendors: [vendor2]
      },
      item3 => {
        quantity: 35,
        vendors: [vendor2, vendor3]
      },
    }
    expect(market.total_inventory).to eq(result)
    end
    
    it "#overstocked_items returns an array of items with more than 1 vendor
    AND total quantity greater than 50" do
    vendor1.stock(item1, 35)
    vendor1.stock(item2, 7)
    vendor2.stock(item4, 50)
    vendor2.stock(item3, 25)
    vendor3.stock(item1, 65)
    vendor3.stock(item3, 10)
    market.add_vendor(vendor1)
    market.add_vendor(vendor2)
    market.add_vendor(vendor3)
    
    expect(market.overstocked_items).to eq([item1])
    end
    
    it "#sorted_item_list returns alphabetized array of items available" do
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3.stock(item1, 65)
      vendor3.stock(item3, 10)
      market.add_vendor(vendor1)
      market.add_vendor(vendor2)
      market.add_vendor(vendor3)
      result = ["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"]
      
      expect(market.sorted_item_list).to eq(result)
    end
  end
end




















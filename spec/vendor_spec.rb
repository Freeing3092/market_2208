require 'rspec'
require './lib/item'
require './lib/vendor'

RSpec.describe Vendor do
  let(:vendor) {Vendor.new("Rocky Mountain Fresh")}
  let(:item1) {Item.new({name: 'Peach', price: "$0.75"})}
  let(:item2) {Item.new({name: 'Tomato', price: '$0.50'})}
  
  context 'initialize' do
    it "exists" do
      expect(vendor).to be_a Vendor
    end
    
    it "has readable attributes" do
      expect(vendor.name).to eq("Rocky Mountain Fresh")
      expect(vendor.inventory).to eq({})
    end
  end
  
  context 'behavior' do
    it "#check_stock returns the number of stock of a provided item" do
      expect(vendor.check_stock(item1)).to eq(0)
    end
    
    it "#stock adds an item in the provided quantity to inventory" do
      vendor.stock(item1, 30)
      expect(vendor.check_stock(item1)).to eq(30)
      
      vendor.stock(item1, 25)
      expect(vendor.check_stock(item1)).to eq(55)
      
      vendor.stock(item2, 12)
      expect(vendor.inventory).to eq({item1 => 55, item2 => 12})
    end
    
    it "#potential_revenue returns the total value of vendor inventory" do
      vendor.stock(item1, 30)
      vendor.stock(item1, 25)
      vendor.stock(item2, 12)
      expect(vendor.potential_revenue).to eq(47.25)
    end
    
    it "#sale reduces quantity by amount sold" do
      vendor.stock(item1, 30)
      vendor.stock(item1, 25)
      vendor.stock(item2, 12)
      
      vendor.sale(item1, 10)
      expect(vendor.check_stock(item1)).to eq(45)
    end
  end
end










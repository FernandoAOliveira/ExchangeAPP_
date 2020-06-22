require 'spec_helper'
require 'json'
require './app/services/converting_service'
 
describe 'Currency' do
  it 'converting' do
    amount = rand(0..9999)
    res = ConvertingService.new("USD", "BRL", amount).perform
    expect(res.is_a? Numeric).to eql(true)
    expect(res != 0 || amount == 0).to eql(true)
  end
end
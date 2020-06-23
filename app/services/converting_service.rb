require 'rest-client'
require 'json'


class ConvertingService
  def initialize(source_currency, target_currency, amount)
    @source_currency = source_currency
    @target_currency = target_currency
    @amount = amount.to_f
  end

  def perform
    begin
      converting_api_url = Rails.application.credentials[Rails.env.to_sym][:currency_api_url]
      converting_api_key = Rails.application.credentials[Rails.env.to_sym][:currency_api_key]
      url = "#{converting_api_url}?token=#{converting_api_key}&currency=#{@source_currency}/#{@target_currency}"
      res = RestClient.get url
      value = JSON.parse(res.body)['currency'][0]['value'].to_f
      
      value * @amount
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end
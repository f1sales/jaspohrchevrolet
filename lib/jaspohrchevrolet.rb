require_relative "jaspohrchevrolet/version"
require 'f1sales_custom/parser'
require 'f1sales_custom/source'
require 'f1sales_custom/hooks'

module Jaspohrchevrolet
  class Error < StandardError; end
  class F1SalesCustom::Hooks::Lead
    def self.switch_source(lead)
      source_name = lead.source.name ? lead.source.name : ''
      message = lead.message ? lead.message : ''
      product_name = lead.product.name ? lead.product.name : ''

      if source_name.downcase.include?('global connect')
        "GC#{source_name.delete_prefix('Global Connect')} - #{lead.message} - #{product_name}"
      else
        source_name
      end
    end
  end
end

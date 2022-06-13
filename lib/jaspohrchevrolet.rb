require_relative "jaspohrchevrolet/version"
require 'f1sales_custom/parser'
require 'f1sales_custom/source'
require 'f1sales_custom/hooks'

module Jaspohrchevrolet
  class Error < StandardError; end
  class F1SalesCustom::Hooks::Lead
    def self.switch_source(lead)
      "#{lead.source.name} - #{lead.message}"  
    end
  end
end

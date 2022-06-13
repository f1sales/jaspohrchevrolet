require_relative "jaspohrchevrolet/version"
require 'f1sales_custom/parser'
require 'f1sales_custom/source'
require 'f1sales_custom/hooks'

module Jaspohrchevrolet
  class Error < StandardError; end
  class F1SalesCustom::Hooks::Lead
    def self.switch_source(lead)
      source_name = lead.source.name ? lead.source.name : ''

      if source_name.downcase.include?('global connect')
        "#{source_name} - #{lead.message}"
      else
        source_name
      end
    end
  end
end

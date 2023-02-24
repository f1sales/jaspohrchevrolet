require_relative "jaspohrchevrolet/version"
require 'f1sales_custom/parser'
require 'f1sales_custom/source'
require 'f1sales_custom/hooks'

module Jaspohrchevrolet
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    def self.switch_source(lead)
      source_name = lead.source.name || ''
      lead_message = lead.message || ''

      if source_name.downcase.include?('global connect')
        source_name = "GC#{source_name.delete_prefix('Global Connect')}"
        source_name += " - #{lead_message}" unless lead_message.empty?
      elsif lead_message.downcase['seminovo']
        source_name += ' - SEMINOVOS'
      end
      source_name
    end
  end
end

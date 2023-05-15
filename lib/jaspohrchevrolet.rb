require_relative "jaspohrchevrolet/version"
require 'f1sales_custom/parser'
require 'f1sales_custom/source'
require 'f1sales_custom/hooks'

module Jaspohrchevrolet
  class Error < StandardError; end

  class F1SalesCustom::Hooks::Lead
    class << self
      def switch_source(lead)
        @lead = lead

        return "#{source_name} - Oficina" if oficina?
        return "#{source_name} - SEMINOVOS" if lead_message_down['seminovo'] || lead_descrip_down['seminovo']

        source_name
      end

      def lead_message_down
        @lead.message&.downcase || ''
      end

      def lead_descrip_down
        @lead.description&.downcase || ''
      end

      def source_name
        @lead.source.name || ''
      end

      def oficina?
        lead_descrip_down['agendamento de serv'] || lead_descrip_down['alerta de revis']
      end
    end
  end
end

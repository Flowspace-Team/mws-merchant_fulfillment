# frozen_string_literal: true

require 'peddler'
require 'nokogiri'
require 'mws/merchant_fulfillment/shipping_services'

module MWS
  module MerchantFulfillment
    class Parser
      include ::Peddler::Headers

      def initialize(response, _encoding)
        @response = response
      end

      def parse
        node = find_result_node

        case node.name
        when /GetEligibleShippingServices/
          ShippingServices.new(node)
        else
          raise NotImplementedError
        end
      end

      def headers
        @response.headers
      end

      private

      def find_result_node
        xml = Nokogiri(@response.body)
        root = xml.children.first

        root.children.find { |node| node.name.include?('Result') }
      end
    end

    # Override Peddler's default Parser.
    Client.parser = Parser
  end
end
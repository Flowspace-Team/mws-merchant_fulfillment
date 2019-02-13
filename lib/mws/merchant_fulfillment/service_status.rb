# frozen_string_literal: true

require 'mws/merchant_fulfillment/entity'
require 'mws/merchant_fulfillment/service_status_message'

module MWS
  module MerchantFulfillment
    class ServiceStatus < Entity
      attribute(:status) do
        text_at_xpath('Status')
      end

      attribute(:timestamp) do
        time_at_xpath('Timestamp')
      end

      attribute(:message_id) do
        text_at_xpath('MessageId')
      end

      attribute(:messages) do
        xpath('Messages/Message').map { |node| ServiceStatusMessage.new(node) }
      end
    end
  end
end
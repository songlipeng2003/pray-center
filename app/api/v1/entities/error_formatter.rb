module V1
  module Entities
    module ErrorFormatter
      def self.call message, backtrace, options, env
        { error: message }.to_json
      end
    end
  end
end

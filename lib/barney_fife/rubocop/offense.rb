module BarneyFife
  module Rubocop
    class Offense < Hashie::Mash

      def body
        "#{self.location.line}:#{self.location.column} - #{self.cop_name} - #{self.message}"
      end
    end
  end
end

module Rubocop
  class Offense
    include Anima.new(:path, :location, :cop_name, :message)

    def line_number
      location['line']
    end

    def column
      location['column']
    end

    def formatted_message
      "#{line_number}:#{column} - #{cop_name} - #{message}"
    end
  end
end

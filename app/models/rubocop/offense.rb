module Rubocop
  class Offense
    include Anima.new(:path, :location, :cop_name, :message)

    def line_number
      location['line']
    end

    def column
      location['column']
    end

    def relative_path
      split_on_temp_path_regex = %r(tmp/rubocop.+/)
      path.split(split_on_temp_path_regex).last
    end

    def formatted_message
      "#{line_number}:#{column} - #{cop_name} - #{message}"
    end
  end
end

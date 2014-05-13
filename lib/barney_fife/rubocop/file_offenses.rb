module BarneyFife
  module Rubocop
    class FileOffenses < Hashie::Mash
      def relative_path
        split_on_temp_path_regex = %r(tmp/rubocop.+/)
        self.path.split(split_on_temp_path_regex)[-1]
      end

      def issues
        @issues ||= self.offenses.map do |off|
                        Offense.new(off)
                      end
      end
    end
  end
end

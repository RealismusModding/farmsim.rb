module FarmSim
  module Tools
    module System
      extend self

      def windows?
        File::ALT_SEPARATOR == "\\"
      end

      def mac?
        RUBY_PLATFORM =~ /darwin/i
      end

      def linux?
        RUBY_PLATFORM =~ /linux/i
      end

      def unix?
        not windows?
      end

    end
  end
end

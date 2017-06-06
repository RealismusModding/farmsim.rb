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

      def modsLocation
        path = userdataLocation

        if path
          return path + "/mods/"
        end

        return nil
      end

      def userdataLocation
        path = nil

        if windows?
          path = Pathname.new("#{ENV["HOME"]}/Documents/My Games/FarmingSimulator2017/")
        else
          path = Pathname.new("#{ENV["HOME"]}/Library/Application Support/FarmingSimulator2017/")
        end

        if path.exist?
          return path
        end

        return nil
      end

      def gameLocation
        path = nil

        if windows?
          path = Pathname.new("C:/Program Files (x86)/Farming Simulator/FarmingSimulator2017.exe")

          if not path.exist?
            path = Pathname.new("C:/Program Files (x86)/Steam/steamapps/common/Farming Simulator 17/FarmingSimulator17.exe")
          end

        else
          path = Pathname.new("#{ENV["HOME"]}/Library/Application Support/Steam/steamapps/common/Farming Simulator 17/Farming Simulator 2017.app")
        end

        if path.exist?
          return path
        end

        return nil
      end

    end
  end
end

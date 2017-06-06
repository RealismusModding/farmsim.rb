require "farmsim/cli"
require "farmsim/tools/system"

require "shellwords"

module FarmSim
  module CLI
    class Run < Command
      description "run Farming Simulator"

      on("-s", "--savegame [ID]", "savegame number") do |c, value|
        c.savegame_id = value
      end

      attr_accessor :savegame_id

      def run
        say "Searching for game executable..."

        path = FarmSim::Tools::System.gameLocation
        error "Location of game not found" if not path

        say "Found game at #{path}"

        params = "-restart"
        params += " -autoStartSavegameId #{savegame_id}" if savegame_id

        say "Starting..."

        if FarmSim::Tools::System.windows?
          system("start \"#{path}\" #{params}")
        else
          system("open -a #{Shellwords.shellescape path} --args #{params}")
        end
      end

    end
  end
end

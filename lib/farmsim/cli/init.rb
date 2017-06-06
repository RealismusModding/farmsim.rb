require "farmsim/cli"
require "farmsim/project"
require "farmsim/tools/system"
require "farmsim/tools/assets"

module FarmSim
  module CLI
    class Init < Command
      description "initialize a new mod project"

      def run(projectName = nil)
        if projectName
          @path = Pathname.getwd + projectName

          error "Directory already exists" if @path.exist?
        else
          @path = Pathname.getwd
          projectName = @path.basename
        end

        error "Project already exists" if descExists?

        @path.mkdir if not @path.exist?
        (@path + "src").mkdir
        (@path + "translations").mkdir

        # Create project file: farmsim.yml
        @projectFile = FarmSim::Project.new()

        copyAsset(".gitignore")
        copyAsset(".gitattributes")
        copyAsset(".fsbuild.yml")
        copyAsset("loader.lua", "src/loader.lua")
        copyAsset("translation_en.xml", "translations/translation_en.xml")
        copyAsset("modDesc.xml")
      end


      private
        def descExists?
          return (@path + "farmsim.yml").exist?
        end

        def writeTextFile(path, text)
          f = File.new(path.to_path, "w")
          f.write(text)
          f.close
        end

        def copyAsset(name, to = name)
          writeTextFile(@path + to, FarmSim::Tools::Assets.asset("init/" + name))
        end

    end
  end
end

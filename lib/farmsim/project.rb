
require "yaml"

module FarmSim
  class Project

    attr_accessor :name, :version, :main, :multiplayer, :zip_name, :desc_version,
      :templates, :base_language, :languages

    # @param path String path of the project
    def initialize(path = nil)
      @name = ""
      @version = "0.0.0.0"
      @main = "src/loader.lua"
      @multiplayer = false
      @zip_name = "mod"
      @desc_version = 37
      @templates = []
      @base_language = "en"
      @languages = ["en"]

      if path
        load(YAML.load_file(path))
      end
    end

    def load(data)
      @name ||= data["name"]
      @version ||= data["version"]
      @main ||= data["main"]
      @multiplayer ||= data["multiplayer"]

      @zip_name ||= data["zip_name"]
      @desc_version ||= data["desc_version"]
      @templates ||= data["templates"]

      if data["translations"]
        @base_language ||= data["translations"]["base"]
        @languages = data["translations"]["languages"] || [@base_language]
      end
    end

    def write(path)
    end

    def to_s
      return "Project{name: #{@name}, version: #{@version}}"
    end

    def zip_name
      return "#{@zip_name}.zip"
    end

  end
end

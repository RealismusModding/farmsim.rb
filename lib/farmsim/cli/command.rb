require "farmsim/cli"
require "farmsim/project"
require "farmsim/tools/system"
require "farmsim/tools/formatter"

require "highline"
require "forwardable"
require "yaml"
require "timeout"

module FarmSim
  module CLI
    class Command

      extend Parser, Forwardable
      def_delegators :terminal, :agree, :ask, :choose

      HighLine.use_color = Tools::System.unix? && $stdout.tty?
      HighLine.color_scheme = HighLine::ColorScheme.new do |cs|
        cs[:command]   = [ :bold             ]
        cs[:error]     = [ :red              ]
        cs[:important] = [ :bold, :underline ]
        cs[:success]   = [ :green            ]
        cs[:info]      = [ :yellow           ]
        cs[:debug]     = [ :magenta          ]
      end

      # Add help parameter to every command
      on("-h", "--help", "Display help") do |c, _|
        c.say c.help
        exit
      end

      on("-q", "--silent", "Silent mode") do |c|
        c.quiet_mode = true
      end

      on("--farmsimfile FILE", "farmsim.yml file") do |c, file|
        c.target_farmsim = Pathname.getwd + file
        puts(c.target_farmsim.to_path)

        c.error "FarmSim file '#{file}' not found" if not c.target_farmsim.exist?
      end

      def self.command_name
        name[/[^:]*$/].split(/(?=[A-Z])/).map(&:downcase).join('-')
      end

      @@abstract ||= [Command] # ignore the man behind the courtains!
      def self.abstract?
        @@abstract.include? self
      end

      def self.abstract
        @@abstract << self
      end

      def self.skip(*names)
        names.each { |n| define_method(n) {} }
      end

      # Set description of the command
      def self.description(description = nil)
        @description = description if description
        @description ||= ""
      end

      def self.subcommands(*list)
        return @subcommands ||= [] if list.empty?
        @subcommands = list

        define_method :run do |subcommand, *args|
          error "Unknown subcommand. Available: #{list.join(', ')}." unless list.include? subcommand.to_sym
          send(subcommand, *args)
        end

        define_method :usage do
          usages = list.map { |c| color(usage_for("#{command_name} #{c}", c), :command) }
          "\nUsage: #{usages.join("\n       ")}\n\n"
        end
      end

      attr_accessor :arguments, :config, :force_interactive, :formatter, :debug, :quiet_mode, :target_farmsim
      attr_reader :input, :output
      alias_method :debug?, :debug

      def initialize(options = {})
        @on_signal  = []
        @formatter  = FarmSim::Tools::Formatter.new
        self.output = $stdout
        self.input  = $stdin
        options.each do |key, value|
          public_send("#{key}=", value) if respond_to? "#{key}="
        end
        @arguments ||= []
      end

      # Utilities for commands
      def projectRoot
        if target_farmsim
          return target_farmsim.dirname
        else
          return Pathname.getwd
        end
      end

      def projectFilePath
        if target_farmsim
          return target_farmsim
        else
          return Pathname.getwd + "farmsim.yml"
        end
      end

      def terminal
        @terminal ||= HighLine.new(input, output)
      end

      def input=(io)
        @terminal = nil
        @input = io
      end

      def output=(io)
        @terminal = nil
        @output = io
      end

      def write_to(io)
        io_was, self.output = output, io
        yield
      ensure
        self.output = io_was if io_was
      end

      def parse(args)
        rest = parser.parse(args)
        arguments.concat(rest)
      rescue OptionParser::ParseError => e
        error e.message
      end

      # Abstract method, usable by inherited classes
      def setup
      end

      # Execute the command
      def execute
        setup
        run(*arguments)
      end

      def command_name
        self.class.command_name
      end


      ###### Help information
      def usage
        "Usage: " << color(usage_for(command_name, :run), :command)
      end

      def usage_for(prefix, method)
        usage = "fs #{prefix}"
        method = method(method)
        if method.respond_to? :parameters
          method.parameters.each do |type, name|
            name = name.upcase
            name = "[#{name}]"   if type == :opt
            name = "[#{name}..]" if type == :rest
            usage << " #{name}"
          end
        elsif method.arity != 0
          usage << " ..."
        end
        usage << " [OPTIONS]"
      end

      def help(info = "")
        parser.banner = usage
        self.class.description.sub(/./) { |c| c.upcase } + ".\n" + info + parser.to_s
      end


      # Output
      def say(data, format = nil, style = nil)
        if not quiet_mode
          terminal.say format(data, format, style)
        end
      end

      def color(line, style)
        return line.to_s unless interactive?
        terminal.color(line || '???', Array(style).map(&:to_sym))
      end

      def interactive?(io = output)
        return io.tty? if force_interactive.nil?
        force_interactive
      end

      def warn(message)
        write_to($stderr) do
          say color(message, :error)
          yield if block_given?
        end
      end

      def error(message, &block)
        warn(message, &block)
        exit 1
      end
    end
  end
end

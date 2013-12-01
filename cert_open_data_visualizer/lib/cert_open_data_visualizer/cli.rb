module CertOpenDataVisualizer
  class CLI
    attr_accessor :argv
    def self.start(argv)
      @argv = argv
      handle
    end

    def self.handle
      visualizer = CertDataVisualizer.new
      commands = {fetch: "fetch!",
                  clean: "clean_cache!",
                  first: "print_first_format",
                  second: "print_second_format",
                  help: "print_help"}
      command = @argv[0].to_sym
      exec = commands[command]

      return help if exec == "print_help"
      return visualizer.send(exec) if exec
      puts "Invalid command #{command}"
    end


    def self.help
      puts "CertOpenDataVisualizer" <<
      " Valid commands are TBA"


    end
  end
end


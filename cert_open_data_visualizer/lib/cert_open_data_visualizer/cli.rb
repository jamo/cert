module CertOpenDataVisualizer
  class Cli
    attr_accessor :argv

    def initialize(argv)
      @argv = argv
    end

    def start
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


    def help
      puts "CertOpenDataVisualizer" <<
      " Valid commands are TBA"
    end
  end
end


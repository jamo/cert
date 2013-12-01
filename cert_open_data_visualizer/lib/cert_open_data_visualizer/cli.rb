module CertOpenDataVisualizer
  class CLI
    attr_accessor :argv

    def initialize(argv)
      @argv = argv
    end

    def start
      visualizer = CertDataVisualizer.new
      commands = {fetch: "fetch!",
                  clean: "clean_cache!",
                  crear: "clean_cache!",
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
      str <<<EOF
CertOpenDataVisualizer
Commands are:
  first  - prints results in format required for first print
  second - prints results in format required for second print
  help   - shows this
  clean  - cleanes cache
  fetch  - fetches new data if neccessary

`first` and `second` may download and parse data when neccesary.

This includes a file cache, for faster results.
ie. information is calculated only when necessary, and cached for
further use. Cache may be cleared using `clean`
EOF

    end
  end
end


module CertOpenDataVisualizer

  require 'httparty'
  require 'tmpdir'
  require 'csv'

  class Visualize
    attr_accessor :all_data, :cacher
    CSV_DATA_URL = "http://pilvilinna.cert.fi/opendata/autoreporter/csv.zip"

    def initialize
      @cacher = DummyCacher.new
    end

    def parse
      maybe_download
      files = extract_and_list_files
      read_and_merge_files(files)
      self
    end

    def maybe_download
      if @cacher.file_exists?("cert.zip")
        puts "Loading data from cache"
        @cacher.get_from_cache("cert.zip")
      else
        download
      end
    end

    def download
      puts "Downloading, may take a while depending on your connection"
      data = HTTParty.get(CSV_DATA_URL).body
      puts "Done"
      write_tmp_file(data)
    end

    def write_tmp_file(contents)
      @cacher.write_file_to_cache "cert.zip", contents
    end

    def extract_and_list_files
      @cacher.unzip_file("cert.zip")
      @cacher.find_files_matching("*.csv")
    end

    def read_and_merge_files(files)
      @all_data = get_csvs(files)
    end

    private
    def get_csvs(files)
      puts "Parsing data, it may take a while"
      csvs = []
      Dir.chdir (@cacher.path) do
        files.each do |file|
          csvs += CSV.read file, col_sep: "|"
        end
        csvs.reject! {|row| row[0].include?('#') || row[5].nil? || row[5] == ""}
        csvs
      end
      puts "Done"
      csvs
    end

  end
end

module CertOpenDataVisualizer

  require 'httparty'
  require 'tmpdir'
  require 'csv'
  require 'json'

  class Visualize
    attr_accessor :all_data, :cacher
    CSV_DATA_URL = "http://pilvilinna.cert.fi/opendata/autoreporter/csv.zip"

    def initialize
      @cacher = DummyCacher.new
    end

    def parse
      maybe_download
      files = maybe_extract_and_list_files
      maybe_read_and_merge_files(files)
      self
    end

    def maybe_download
      if @cacher.file_exists?("cert.zip")
        puts "File found in cache, not downloading"
      else
        download
      end
    end

    def download
      puts "Downloading, may take a while depending on your connection"
      data = HTTParty.get(CSV_DATA_URL).body
      puts "Done"
      write_tmp_file("cert.zip", data)
    end

    def write_tmp_file(filename, contents)
      @cacher.write_file_to_cache filename, contents
    end

    def maybe_extract_and_list_files
      if @cacher.file_exists? "cert.zip" and not @cacher.file_exists? "certfi_autoreporter_opendata_2006.csv"
        @cacher.unzip_file("cert.zip")
      end
      @cacher.find_files_matching("*.csv")
    end

    def maybe_read_and_merge_files(files)
      if @cacher.file_exists? "all_data.json"
        @all_data = JSON.parse(File.read(@cacher.get_from_cache("all_data.json")))
      else
        @all_data = get_csvs(files)
        write_tmp_file("all_data.json", @all_data.to_json)
      end
      @all_data
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

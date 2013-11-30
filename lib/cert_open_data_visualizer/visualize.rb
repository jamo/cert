module CertOpenDataVisualizer
  require 'httparty'
  require 'tmpdir'
  require 'json'

  class Visualize
    attr_accessor :file_content, :files, :all_data, :cacher, :data_file_tmp_dir
    CSV_DATA_URL = "http://pilvilinna.cert.fi/opendata/autoreporter/csv.zip"

    def initialize
      @cacher = DummyCacher.new
      @data_file_tmp_dir = Dir.mktmpdir
    end

    def parse
      maybe_download.write_extract_and_list_files.read_and_merge_files
      self
    end


    def download
      @file_content = HTTParty.get(CSV_DATA_URL).body
      self
    end

    def maybe_download
      if @cacher.file_exists?("cert.zip")
        @file_content = File.read @cacher.get_from_cache("cert.zip")
      else
        download
        write_tmp_file(true)
      end
    end

    def write_tmp_file(cache = false)
      Dir.chdir(@data_file_tmp_dir) do
        File.open("cert.zip", "wb") { |file| file.write(@file_content) }
        if cache
          @cacher.cache_file "cert.zip"
        end
      end
    end


    def write_extract_and_list_files
      files = []
      Dir.chdir(@data_file_tmp_dir) do
        File.open("cert.zip", "wb") { |file| file.write(@file_content) }
        # Because I have found rubyzip to be buggy, we rely that your system has zip-command available
        `unzip cert.zip`
        @files = Dir.glob('csv/*.csv')
      end
      self
    end


    def read_and_merge_files
      @all_csv = get_csvs
      self
    end

    def merge_jsons(csvs)
      data = []
      csvs.each do |json|
        opendata = json["autoreporter"]["opendata"]
      end
      data
    end

    private
    def get_csvs
      csvs = []
      @files.each do |file|
        csvs += CSV.read file, col_sep: "|"
      end
      csvs.reject! {|row| rob[0] == '#'}
      csvs
    end

  end
end

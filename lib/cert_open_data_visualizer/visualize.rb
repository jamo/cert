module CertOpenDataVisualizer
  class Visualize
    def parse
      file = download
      handle_file(file)
    end

    JSON_DATA_URL = "http://pilvilinna.cert.fi/opendata/autoreporter/json.zip"

    def download
      HTTParty.get(JSON_DATA_URL).body
    end

    def handle_file(file)
      Dir.mktmpdir do |dir|
        puts dir.inspect
      end
    end

  end

end

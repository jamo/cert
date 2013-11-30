module CertOpenDataVisualizer

  require 'fileutils'

  class DummyCacher
    # Yep, well just overwrite it if it exists
    def cache_file(path)
      FileUtils.mkdir_p( File.join(Dir.tmpdir, "cert"))
      FileUtils.cp(path, File.join(Dir.tmpdir, "cert"))
    end

    def get_from_cache(file_name)
      File.join(Dir.tmpdir , "cert", file_name)
    end

    def file_exists?(file_name)
      File.exists? get_from_cache(file_name)
    end

  end
end

module CertOpenDataVisualizer

  require 'fileutils'

  class DummyCacher

    def initialize
      FileUtils.mkdir_p(path)
    end

    # Yep, well just overwrite it if it exists
    def cache_file(path)
      FileUtils.mkdir_p( File.join(Dir.tmpdir, "cert"))
      FileUtils.cp(path, File.join(Dir.tmpdir, "cert"))
    end

    def write_file_to_cache(filename, contents)
      Dir.chdir(path) do
        File.open(filename, "wb") { |file| file.write(contents) }
      end
    end

    def get_from_cache(file_name)
      File.join(path,  file_name)
    end

    def file_exists?(file_name)
      File.exists? get_from_cache(file_name)
    end

    def tmpdir_path
      Dir.tmpdir
    end

    def unzip_file(file_name)
      Dir.chdir(path) do
        # Because I have found rubyzip to be buggy, we rely that your system has zip-command available
        `unzip -o  #{file_name}`
      end
    end

    def find_files_matching(matcher)
      files = []
      Dir.chdir(path) do
        files = Dir.glob(matcher)
      end
      files
    end

    def path
      File.join(Dir.tmpdir, "cert")
    end

    def clean!
      FilrUtils.rm_rf path
    end

  end
end

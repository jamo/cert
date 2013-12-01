require "cert_open_data_visualizer/version"
require "cert_open_data_visualizer/visualize"
require "cert_open_data_visualizer/dummy_cacher"
require "cert_open_data_visualizer/formatter"
require "cert_open_data_visualizer/cli"

class CertDataVisualizer
  attr_accessor :formatter
  def initialize
    @formatter = CertOpenDataVisualizer::Formatter.new
  end

  def first_format
    @formatter.first_format
  end

  def print_first_format
    puts first_format
  end

  def second_format
    @formatter.second_format
  end

  def print_second_format
    puts second_format
  end

  def clean_cache!
    CertOpenDataVisualizer::DummyCacher.new.clean!
  end

  def fetch!
   @formatter.data = CertOpenDataVisualizer::Visualize.new.parse.all_data
  end

end

module CertOpenDataVisualizer
  # Your code goes here...
end

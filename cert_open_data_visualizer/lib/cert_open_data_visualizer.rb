require "cert_open_data_visualizer/version"
require "cert_open_data_visualizer/visualize"
require "cert_open_data_visualizer/dummy_cacher"
require "cert_open_data_visualizer/formatter"

class CertDataVisualizer
  attr_accessor :formatter
  def initialize
    @formatter = CertOpenDataVisualizer::Formatter.new
  end

  def first_format
    @formatter.first_format
  end

  def second_format
    @formatter.second_format
  end

  def clean_cache!
    DummyCacher.new.clean!
  end
end

module CertOpenDataVisualizer
  # Your code goes here...
end

require 'sinatra'
require 'haml'
require 'cert_open_data_visualizer'
class App < Sinatra::Base
  attr_accessor :visualizer, :first_format, :second_format

  get '/' do
    @visualizer ||= CertDataVisualizer.new
    if params[:reload]
      @visualizer.clean_cache!
      @visualizer.fetch!
    end

    @first_format ||= @visualizer.first_format
    @second_format ||= @visualizer.second_format
    haml :index
  end

end

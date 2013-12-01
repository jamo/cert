require 'sinatra'
require 'haml'
require 'cert_open_data_visualizer'
class App < Sinatra::Base
  attr_accessor :visualizer

  get '/' do
    @visualizer = CertDataVisualizer.new
    @first_format = @visualizer.first_format
    @seconf_format = @visualizer.seconf_format
    haml :index
  end

end

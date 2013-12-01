require 'sinatra'
require 'haml'
require 'cert_open_data_visualizer'
class App < Sinatra::Base
  attr_accessor :visualizer, :first_format, :second_format

  get '/' do
    @visualizer ||= CertDataVisualizer.new
    @first_format ||= @visualizer.first_format
    @seconf_format ||= @visualizer.second_formt
    haml :index
  end

end

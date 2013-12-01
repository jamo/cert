require 'sinatra'
require 'haml'
require 'cert_open_data_visualizer'
require 'json'

class App < Sinatra::Base
  attr_accessor :visualizer, :first_format, :second_format

  get '/' do
    @visualizer ||= CertDataVisualizer.new

    @first_format ||= @visualizer.first_format
    @second_format ||= @visualizer.second_format
    haml :index
  end

  get '/charts' do
    @visualizer ||= CertDataVisualizer.new

    @first_format ||= @visualizer.first_format
    @second_format ||= @visualizer.second_format


    @first_format_json = Hash[@first_format.split("\n").collect { |k| [k.split(" ")[0], k.split(" ")[1] ]}].to_json
    @second_format_json = Hash[@second_format.split("\n").collect { |k| [k.split(" ")[0], k.split(" ")[1] ]}].to_json
    haml :charts
  end


  get '/reload' do
    haml :reset
  end

  get '/reset' do
    @visualizer ||= CertDataVisualizer.new
    @visualizer.clean_cache!
    @visualizer.fetch!
    redirect to('/')
  end

end

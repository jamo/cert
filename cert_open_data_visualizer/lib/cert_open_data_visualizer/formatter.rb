module CertOpenDataVisualizer
  class Formatter
    attr_accessor :data, :cacher, :visualizer

    def initialize
      @visualizer = Visualize.new
      @cacher = @visualizer.cacher
    end

    # 0: date from
    # 1: date to
    # 2: anon AS-number
    # 3: anon IP-address
    # 4: IP version
    # 5: maincategory
    # 6: subcategory
    # 7: cc
    # 8: city
    def first_format
      if @cacher.file_exists?("first_challenge")
        return File.read(@cacher.get_from_cache("first_challenge"))
      else
        load_data! if @data.nil?
      end
      incidents = count_main_incidents
      incidents_str = ""
      incidents.each do |incident|
        incidents_str <<  "#{incident[0]} #{incident[1]}\n"
      end
      @cacher.write_file_to_cache("first_challenge", incidents_str)
      incidents_str
    end

    def second_format
      if @cacher.file_exists?("second_challenge")
        return File.read(@cacher.get_from_cache("second_challenge"))
      else
        load_data! if @data.nil?
      end
      incidents = count_incidents_based_on_location
      incidents_str = ""
      incidents.each do |incident|
        incidents_str <<  "#{incident[0]} #{incident[1]}\n"
      end
      @cacher.write_file_to_cache("second_challenge", incidents_str)
      incidents_str
    end

    def filter_by_city(name)
      # get everything matching
      load_data! if @data.nil?
      filterd = @data.select do |line|
        line[8].downcase.include? name
      end

      # create hash for formatting
      results = generate_city_hash(filterd)
      # print in nice format
      print_city_results(results)
    end

    def generate_city_hash(list)
      results = {}
      list.each do |l|
        country, city, main, sub = l[7], l[8], l[5], l[6]
        if results[country].nil?
          results[country] = { city => { main => { sub => 1 } }}
        elsif results[country][city].nil?
          results[country][city] = {main => { sub => 1 } }
        elsif results[country][city][main].nil?
          results[country][city][main] = { sub => 1 }
        elsif results[country][city][main][sub].nil?
          results[country][city][main][sub] = 1
        else
          results[country][city][main][sub] += 1
        end
      end
      results
    end

    def print_city_results(results)
      results.keys.each do |country|
        puts "#{country}:"
        next if results[country].nil?
        results[country].keys.each do |city|
          puts "  #{city}:"
          next if results[country][city].nil?
          results[country][city].keys.each do |main|
            puts "    #{main}:"
            next if results[country][city][main].nil?
            results[country][city][main].keys.each do |sub|
              puts "      #{sub}: #{results[country][city][main][sub] }"
            end
          end
        end
      end
    end

    private
    def count_main_incidents
      incidents = {}
      load_data! if @data.nil?
      @data.each do |row|
        main_incident = row[5]
        if incidents[main_incident]
          incidents[main_incident] = incidents[main_incident] + 1
        else
          incidents[main_incident] = 1
        end
      end
      incidents
    end

    def count_incidents_based_on_location
      incidents = {}
      load_data! if @data.nil?
      @data.each do |row|
        ccode, city = row[7], row[8]
        name = "#{ccode}#{city}"
        if incidents[name]
          incidents[name] = incidents[name] + 1
        else
          incidents[name] = 1
        end
      end
      incidents
    end

    def load_data!
      @data = @visualizer.parse.all_data
    end

  end
end

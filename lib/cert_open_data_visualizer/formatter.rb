module CertOpenDataVisualizer
    class Formatter
      attr_accessor :data
      def initialize
        @data = Visualize.new.parse.all_data
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
        incidents = count_main_incidents
        incidents.each do |incident|
          puts "#{incident} #{incidents[incident]}"
        end

      end

      def count_main_incidents
        incidents = {}
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

    end
end

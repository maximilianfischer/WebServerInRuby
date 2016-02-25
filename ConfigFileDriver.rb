# we can use this to test HttpdConfig.rb and MimeTypes.rb
#require_relative 'HttpdConfig'
require_relative 'MimeTypes'
class ConfigFileDriver

    def start
        lines_from_mime_types = IO.readlines "config/mime.types"
        lines_from_httpd_config = IO.readlines "config/httpd.config"

        #lines_from_httpd_config.each { |line| puts line }

        # httpd_config = HttpdConfig.new( lines_from_mime_types )
        # httpd_config.load

        mime_types = MimeTypes.new( lines_from_mime_types )
        mime_types.load
        puts mime_types.for("html")
    end

    ConfigFileDriver.new().start
end

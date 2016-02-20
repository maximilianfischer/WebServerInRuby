require 'socket'
require 'uri'
class Request
  WEB_ROOT = './public'

  def initialize(socket)
    @request_line   = socket.gets
    @path = requested_file()
    STDERR.puts "Inside Requset.rb initializer:  #{@request_line}"
  end



  attr_reader :path

  def requested_file()
    request_uri = @request_line.split(" ")[1]
    path =  URI.unescape(URI(request_uri).path)

    clean = []

    parts = path.split("/")

    parts.each do |part|
      next if part.empty? || part == '.'
      part == '..'?clean.pop : clean << part
    end

    File.join(WEB_ROOT, *clean)
  end
end

require_relative 'request'

class Response

  CONTENT_TYPE_MAPPING = {
      'html' => 'text/html',
      'txt' => 'text/plain',
      'png' => 'image/png',
      'jpg' => 'image/jpeg',
  }

  DEFAULT_CONTENT_TYPE = 'application/octet-stream'

  def initialize(request,skt)
    @socket = skt
    @request = request
    @ver = '1.1 '
    @code
    @contentType
    @body = '<html><body>Hello World</body></html>'
    @contentLegnth = @body.bytesize
    @connection = 'close'
    @response_line
    write_to_Socket
  end

  attr_reader :code

  def bytesize()
    @code.bytesize
  end

  def write_to_Socket
    @path = @request.path
    @path = File.join(@path, 'index.html') if File.directory?(@path)
    #@path = 'index.html'
    STDERR.puts "Inside write_to_socket:FILE PATH :: #{@path}"
    puts File.exist?(@path)
    puts File.path(@path).to_s
    if File.exist?(@path) && !File.directory?(@path)
      @code = '200 OK'
      @content_type = content_type
      File.open(@path,"rb") do |file|
        @socket.print"HTTP/#{@ver}#{@code}\r\n" +
            "Content-Type: #{@content_type}\r\n" +
            "Content-Length: #{file.size}\r\n"+
            "Connection: close\r\n"
        @socket.print "\r\n"
        IO.copy_stream(file, @socket)
      end
    end
  else
    message = "file not found\n"
    @socket.print
    @socket.print "HTTP/1.1 404 Not Found\r\n" +
                     "Content-Type: text/plain\r\n" +
                     "Content-Length: #{message.size}\r\n" +
                     "Connection: close\r\n"

    @socket.print "\r\n"

    @socket.print message
  end


  def content_type()
    ext = File.extname(@path).split(".").last
    STDERR.puts "Inside content_type:: extension :: #{ext}"
    CONTENT_TYPE_MAPPING.fetch(ext, DEFAULT_CONTENT_TYPE)
  end

end




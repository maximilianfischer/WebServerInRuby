require 'socket'
#require_relative 'Response'
#require_relative 'Request'
server = TCPServer.new('localhost', 15000)
loop do
  puts "server running"
  socket = server.accept
  request = Request.new(socket)
  response = Response.new(request,socket)
  socket.close
end
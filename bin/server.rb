require 'webrick'

server = WEBrick::HTTPServer.new(:Port => 3000)

server.mount_proc("/") do |request, response|
  if request.path
    str = request.path
    response.body = "#{str}"
  else
    str = "You did not provide any parameters "
    response.body = "#{str}"
  end

response.content_type = "text/text"

end

trap('INT') do
  server.shutdown
end

server.start

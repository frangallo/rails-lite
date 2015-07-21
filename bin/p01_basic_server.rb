require 'webrick'
require 'byebug'

# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPRequest.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/HTTPResponse.html
# http://www.ruby-doc.org/stdlib-2.0/libdoc/webrick/rdoc/WEBrick/Cookie.html
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

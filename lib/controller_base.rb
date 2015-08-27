require_relative './params'
require_relative './session'
require 'active_support'
require 'active_support/core_ext'
require 'erb'


class ControllerBase
  attr_reader :req, :res
  attr_accessor :already_built_response

  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @already_built_response = false
    @params = Params.new(req, route_params)
  end

  def already_built_response?
    @already_built_response
  end

  def redirect_to(url)
    raise if already_built_response?
    self.res.header["location"] = url unless already_built_response?
    self.res.status = 302
    self.already_built_response = true
    @session.store_session(self.res)
  end

  def render_content(content, content_type)
    raise if already_built_response?
    self.res.content_type = content_type
    self.res.body = content
    self.already_built_response = true
  end

  def render(template_name)
    template_file = File.read(
                          File.join(
                          "views",
                          self.class.name.underscore,
                          "#{template_name}.html.erb")
                          )
    erb_file = ERB.new(template_file).result(binding)
    render_content(erb_file, "text/html")
  end

  def session
   @session ||= Session.new(req)
  end

 def invoke_action(name)
   self.send(name)
   render(name) unless already_built_response?

   nil
 end

end

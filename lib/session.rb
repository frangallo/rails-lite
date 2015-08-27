require 'json'
require 'webrick'

class Session

  def initialize(req)
    @req = req
    cookie = req.cookies.find { |cookie| cookie.name == '_rails_lite_app' }
    @cookie_info = cookie ? JSON.parse(cookie.value) : {}
  end

  def [](key)
    @cookie_info[key]
  end

  def []=(key, val)
    @cookie_info[key] = val
  end

  def store_session(res)
    res.cookies << WEBrick::Cookie.new('_rails_lite_app', @cookie_info.to_json)
  end
end

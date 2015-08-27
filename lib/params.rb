require 'uri'

class Params

  def initialize(req, route_params = {})
    @params = {}
    @params.merge!(route_params)
    @params.merge!(parse_www_encoded_form(req.body)) if req.body
    @params.merge!(parse_www_encoded_form(req.query_string)) if req.query_string
  end

  def [](key)
    @params[key.to_s] || @params[key.to_sym]
  end

  def to_s
    @params.to_s
  end

  class AttributeNotFoundError < ArgumentError; end;

  private

  def parse_www_encoded_form(www_encoded_form)
    params = {}

    values = URI.decode_www_form(www_encoded_form)

    values.each do |full_key, value|
      current = params

      key_seq = parse_key(full_key)
      key_seq.each_with_index do |k, i|
        if (i + 1) == key_seq.count
          current[k] = value
        else
          current[k] ||= {}
          current = current[k]
        end
      end
    end
    params
  end

  def parse_key(key)
    key.split(/\[|\]\[|\]/)
  end
end

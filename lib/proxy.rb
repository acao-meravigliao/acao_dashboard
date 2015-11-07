require "net/http"

# Example Usage:
#
# use Rack::Proxy do |req|
# if req.path =~ %r{^/remote/service.php$}
# URI.parse("http://remote-service-provider.com/service-end-point.php?#{req.query}")
# end
# end
#
# run proc{|env| [200, {"Content-Type" => "text/plain"}, ["Ha ha ha"]] }
#
class Rack::Proxy
  def initialize(app, &block)
    self.class.send(:define_method, :uri_for, &block)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    method = req.request_method.downcase
    method[0..0] = method[0..0].upcase

    return @app.call(env) unless uri = uri_for(req)

    sub_request = Net::HTTP.const_get(method).new("#{uri.path}#{"?" if uri.query}#{uri.query}")
    if sub_request.request_body_permitted?
      if req.body && req.content_type
        sub_request.body = req.body.read
        sub_request.content_length = req.content_length
        sub_request.content_type = req.content_type
      else
        sub_request.content_length = 0
      end
    end

    sub_request['Authorization'] = req.env['HTTP_AUTHORIZATION'];
    sub_request['Cookie'] = req.env['HTTP_COOKIE'];
    sub_request['X-Ygg-Session-Id'] = req.env['HTTP_X_YGG_SESSION_ID'];

    sub_request["X-Forwarded-For"] = (req.env["X-Forwarded-For"].to_s.split(/, +/) + [req.env['REMOTE_ADDR']]).join(", ")
    sub_request["X-Requested-With"] = req.env['HTTP_X_REQUESTED_WITH'] if req.env['HTTP_X_REQUESTED_WITH']
    sub_request["Accept-Encoding"] = req.accept_encoding
    sub_request["Referer"] = req.referer
    sub_request['User-Agent'] = req.env['HTTP_USER_AGENT']
    sub_request['Accept'] = req.env['HTTP_ACCEPT']
    sub_request['X-Request-Id'] = req.env['HTTP_X_REQUEST_ID']
    sub_request.basic_auth *uri.userinfo.split(':') if (uri.userinfo && uri.userinfo.index(':'))

    begin
      http = Net::HTTP.new(uri.hostname, uri.port)
#http.set_debug_output(STDERR)
      sub_response = http.start do |http|

        http.request(sub_request)
      end
    rescue StandardError => e
      return [503, { 'Content-type' => 'text/plain' }, [ "Hel not available: #{e.to_s}" ]]
    end

    headers = {}
    sub_response.each_header do |k,v|
      headers[k] = v unless k.to_s =~ /content-length|transfer-encoding|status/i
    end

    [sub_response.code.to_i, headers, [sub_response.read_body]]
  end
end

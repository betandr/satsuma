require 'net/http'
require "net/https"
require 'json'
require 'uri'

class FeedLoader
  
  CERTIFICATE_FILE = "/Users/anderb08/workspace/dev.bbc.co.uk.pem"
  
  def load_feed(url, options = {})
    response = request_feed(url, options)
    JSON.parse(response)
  end
  
  private 
    def request_feed(url, options = {})
      uri = URI.parse(url)
      use_proxy = options[:use_proxy].nil? ? true : options[:use_proxy]
      use_cert = options[:use_cert].nil? ? false : options[:use_cert]

      if use_proxy
        p "Creating proxied request to #{uri.host} on port #{uri.port}"
        proxy = Net::HTTP::Proxy('www-cache.reith.bbc.co.uk', 80)
        http = proxy.new(uri.host, uri.port)
      else
        p "Creating direct request to #{uri.host} on port #{uri.port}"
        http = Net::HTTP.new(uri.host, uri.port)
      end

      if uri.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      if use_cert
        p "Using certificate at #{CERTIFICATE_FILE}"
        http.cert = OpenSSL::X509::Certificate.new(File.read(CERTIFICATE_FILE))
        http.key = OpenSSL::PKey::RSA.new(File.read(CERTIFICATE_FILE))
      end

      request = Net::HTTP::Get.new(uri.request_uri)
      p "Requesting #{uri.host}:#{uri.port}#{uri.request_uri} via #{uri.scheme}"

      if http.respond_to? "request"
        p "Requesting #{uri.host}:#{uri.port}#{uri.request_uri} via #{uri.scheme}"
        response = http.request(request)
        p "Recieved #{response.size} byte response."
        feed = response.body

      else
        http.start do |http_session|
        p "Requesting #{uri.request_uri} via #{uri.scheme}"
        response = http_session.request(request)
        p "Recieved #{response.size} byte response."
        feed = response.body
      end
    
      feed
    end
    
  end
end
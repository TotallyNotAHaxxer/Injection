require 'socket'
require 'net/http'
require 'colorize'
require 'optparse'
require 'httparty'
require 'timeout'
require 'uri'

url     = ARGV[0] || "".empty?

URI.parse("#{url}").port # => 80
uri = URI.parse("#{url}")
if ARGV.empty?
    puts '[-] No Argument'.colorize(:red)
    sleep 1 
    puts "[-] Try #{__FILE__} https://github.com www.github.com".colorize(:blue)
    puts '[-] Exiting'.colorize(:red)
    exit!
end
date = Time.new 
puts  '         Date At Start ===> '.colorize(:yellow) + date.inspect .colorize(:red)
puts  '         Url Target    ===> '.colorize(:yellow) + url    .colorize(:red)
puts '-------------------------------------------------------'
puts "[*] Target is => ".colorize(:blue) + url.colorize(:red)
puts '-------------------------------------------------------'  
sleep 1 
puts '[*] Gathering Info on URL => '.colorize(:blue) + url.colorize(:red)
puts '---------------- BASIC INFORMATION FOR URL -------------- '
uri = URI.parse("#{url}")
http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)
request["User-Agent"] = "My Ruby Script"
request["Accept"] = "*/*"
response = http.request(request)
response["content-type"]
response.each_header do |key, value|
  p "#{key} => #{value}"
end
p response.instance_variable_get("@header")
userag     = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/94.0.4606.54 Safari/537.36"
proxy_user = nil
proxy_pass = nil 
uri  = URI.parse("#{url}")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl        = true if uri.scheme == 'https'
http.verify_mode    = OpenSSL::SSL::VERIFY_NONE
req  = Net::HTTP::Get.new(uri.request_uri)
pp req.to_hash
req["User-Agent"] = "#{userag}"
res   = http.request(req)
res.code
res.message 
res.code_type
res.content_type
pp res.to_hash
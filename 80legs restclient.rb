require 'rest-client'
require 'json'
require 'rubygems'
require 'net/http'
require 'uri'
require 'open-uri'

user_token = "x3v8wfgqhmyja687havucn1zr8yyy1fx"
crawl_name = "AmazonBuyBox_API2"
options = {
        "app": "AmazonBuyBox",
        "urllist": "Amazon_Key_Items",
        #{}"data": "17011015 API Key Items",
        "max_depth": 0,
        "max_urls": 50
    }
=begin
RestClient.put "https://#{user_token}:@api.80legs.com/v2/crawls/#{crawl_name}", options.to_json, {content_type: :json} do |response, request|
      p request
      p response
      @status = response.code
end

if @status < 400
    puts "Created crawl!"
else
    puts "Crawl creation failed!"
end
=end

crawlStatus = RestClient.get "https://#{user_token}:@api.80legs.com/v2/crawls/AmazonBuyBox_API2"
#puts crawlStatus

crawlResult = JSON.parse(RestClient.get "https://#{user_token}:@api.80legs.com/v2/results/AmazonBuyBox_API2")
puts crawlResult

uri = URI.parse(crawlResult[0])

http = Net::HTTP.new(uri.host, uri.port)
request = Net::HTTP::Get.new(uri.request_uri)

response = http.request(request)

if response.code == "200"
  result = JSON.parse(response.body)
  #puts result
  
  #result.each do |doc|
    #puts "url: " + doc["url"] #reference properties like this
    #puts "result: " + (doc["result"])
    #puts doc  
    #puts ""
 # end
else
  puts "ERROR!!!"
end

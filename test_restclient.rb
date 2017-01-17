require 'rest-client'
require 'json'
require 'rubygems'
require 'net/http'
require 'uri'
require 'open-uri'

date = Time.now.strftime("%y%m%d")
time = Time.now.strftime("%H%M")

userToken = "x3v8wfgqhmyja687havucn1zr8yyy1fx"
crawlName = "#{date}_#{time}_AmazonBuyBox"
app = "AmazonBuyBox"
urlList = "Amazon_Key_Items"
options = {
  "app": app,
  "urllist": urlList,
  #"data": "17011015 API Key Items",
  "max_depth": 0,
  "max_urls": 50
}

fileName = "#{date}_#{time}_#{urlList}.json"
=begin
# run the crawl
RestClient.put "https://#{userToken}:@api.80legs.com/v2/crawls/#{crawlName}", options.to_json, {content_type: :json} do |response, request|
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

resultStatus = 440
resultBody = ""

until resultStatus===200 do

	#puts "not yet: code is #{resultStatus}"
	#sleep 5
	
    #RestClient.get "https://#{userToken}:@api.80legs.com/v2/results/#{date}_#{time}_AmazonBuyBox" do |response, request|
    RestClient.get "https://#{userToken}:@api.80legs.com/v2/results/170117_1643_AmazonBuyBox" do |response, request|
       	resultStatus = response.code
      	resultBody = response.body
    end
end

remote_full_url = JSON.parse(resultBody)[0]
#remote_full_url = "http://datafiniti-voltron-results.s3.amazonaws.com/x3v8wfgqhmyja687havucn1zr8yyy1fx/343093_1.txt?AWSAccessKeyId=AKIAIELL2XADVPVJZ4MA&Signature=UdbFGW96Ko53CKMpupA6fSBLuuA%3D&Expires=1485294212"
puts remote_full_url
remote_data = open(remote_full_url).read

my_local_file = open(fileName, "w") 

my_local_file.write(remote_data)
my_local_file.close
=begin
RestClient.get "https://#{userToken}:@api.80legs.com/v2/results/170117_1643_AmazonBuyBox" do |response, request|
      p request
      p response
      p JSON.parse(response.to_s)
      @status = response.code
end
 puts @status
=end

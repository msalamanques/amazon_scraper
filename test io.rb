require "open-uri"

remote_full_url = "http://datafiniti-voltron-results.s3.amazonaws.com/x3v8wfgqhmyja687havucn1zr8yyy1fx/337479_1.txt?AWSAccessKeyId=AKIAIELL2XADVPVJZ4MA&Signature=LkCSm7%2BD18ebhM%2FgXEFQMkiYm2Y%3D&Expires=1484686617"

remote_data = open(remote_full_url).read

date = Time.now.strftime("%y%m%d")
time = Time.now.strftime("%H%M")

fileName = "#{date}_#{time}_Key_Items.json"

my_local_file = open(fileName, "w") 

my_local_file.write(remote_data)
my_local_file.close



#puts "#{date}_#{time}_Key_Items.json"



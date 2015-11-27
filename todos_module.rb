require 'httparty'
require 'yaml'


module TodosUtil

   @data = YAML.load(File.open('links.yml'))

   def self.post

      post = @data['urls'][0]["post"]
      title = @data['urls'][0]["title"]
    	HTTParty.post post, query:{title: "#{title}", due: "2015-01-01"}

   end
   def self.get(id)

     	get = @data['urls'][0]["get"]
     	HTTParty.get "#{get}#{id}"

   end
   def self.delete(id)

     	delete = @data['urls'][0]["delete"]
     	HTTParty.delete "#{delete}#{id}"

   end
end

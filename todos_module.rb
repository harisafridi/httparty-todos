require 'httparty'

module TodosUtil
 def self.post
	r= HTTParty.post "http://lacedeamon.spartaglobal.com/todos", 
	query:{title: "An Item", due: "2015-01-01"}
	r= r["id"]
 end
 def self.delete(id)
 	 HTTParty.delete "http://lacedeamon.spartaglobal.com/todos/#{id}"
    puts "successfully teardown posting a message"
 end
end
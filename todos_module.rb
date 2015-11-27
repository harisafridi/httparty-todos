require 'httparty'

module TodosUtil
 def self.post
	HTTParty.post "http://lacedeamon.spartaglobal.com/todos", 
	query:{title: "An Item", due: "2015-01-01"}
	
 end
 def self.delete(id)
 	 HTTParty.delete "http://lacedeamon.spartaglobal.com/todos/#{id}"
 end
end
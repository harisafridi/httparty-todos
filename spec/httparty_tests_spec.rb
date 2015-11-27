require 'httparty'
require 'spec_helper'
$LOAD_PATH << '.'
require "todos_module"


describe "Test Suite sends a post request" do
  it "should create a new post in collection" do
     #execute
      id = TodosUtil.post
     #verify
      expect(id['title']).to eq("An Item")
	    expect(id.code).to eq(201)
      expect(id.message).to eq("Created")
      expect(id['due']).to eq("2015-01-01")
    #teardown
      TodosUtil.delete(id['id'])
  end
  it "should fail to make a post without proper arguments" do
      r= HTTParty.post "http://lacedeamon.spartaglobal.com/todos", query:{title: "An Item"} 
      #verify
      expect(r.code).to eq(422)
      expect(r.message).to eq("Unprocessable Entity")
  end
  it "should fail to make a post without any arguments" do
      r= HTTParty.post "http://lacedeamon.spartaglobal.com/todos", query:{} 
      #verify
      expect(r.code).to eq(422)
      expect(r.message).to eq("Unprocessable Entity")
  end
   it "should fail to make a post with specific id" do
      r= HTTParty.post "http://lacedeamon.spartaglobal.com/todos/2248", query:{title: "An Item", due: "01-01-2012"} 
      #verify
      expect(r.code).to eq(405)
      expect(r.message).to eq("Method Not Allowed")
  end
end

describe "Test Suite sends a get request" do
  it "should read/get the hash at a specific ID" do
      id = TodosUtil.post
      r= HTTParty.get "http://lacedeamon.spartaglobal.com/todos/#{id['id']}"
      expect(r["title"]).to eq("An Item")
      expect(r.code).to eq(200)
      expect(r.message).to eq("OK")
      expect(r['due']).to eq("2015-01-01")
      #teardown
      TodosUtil.delete(id['id'])
  end
  it "should return an empty hash from an empty ID" do
      r= HTTParty.get "http://lacedeamon.spartaglobal.com/todos/00"
      expect(r.code).to eq(404)
      expect(r.message).to eq("Not Found")
  end 
  it "should return all IDs if collection if requested" do
    r= HTTParty.get "http://lacedeamon.spartaglobal.com/todos/"
    expect(r.code).to eq(200)
    expect(r.message).to eq("OK")
    expect(r.content_type).to eq("application/json")
  end
end

describe "Test Suite sends a put request" do
  it "should update a single todo from an ID" do
    id = TodosUtil.post
    r= HTTParty.put "http://lacedeamon.spartaglobal.com/todos/#{id['id']}", query:{title: "Changed An Item to Another Item", due: "2015-01-01"}
    expect(r["title"]).to eq("Changed An Item to Another Item")
   
    expect(r.code).to eq(200)
    expect(r.message).to eq("OK")
    expect(r['due']).to eq("2015-01-01")
    #teardown
    TodosUtil.delete(r['id'])
  end
end

describe "Test Suite sends a patch request" do
  it "should check whether that specific post was modified" do
    id = TodosUtil.post
    r= HTTParty.patch "http://lacedeamon.spartaglobal.com/todos/#{id['id']}", query:{title: "Changed An Item only but not due date"}
    expect(r["title"]).to eq("Changed An Item only but not due date")
    expect(r.code).to eq(200)
    expect(r.message).to eq("OK")
    expect(r['due']).to eq("2015-01-01")
    #teardown
    TodosUtil.delete(r['id'])
  end
end

describe "Test suite sends a delete request" do
  it "should delete a single todo" do  
    id = TodosUtil.post
    delete=  TodosUtil.delete id['id']
    expect(delete['id']).to eq (nil)  
    expect(delete.code).to eq(204)
    expect(delete.message).to eq("No Content")
    expect(delete.content_type).to eq(nil)
  end  
  it "should not delete todo collection" do
    delete = HTTParty.delete "http://lacedeamon.spartaglobal.com/todos/"
    expect(delete['id']).to eq (nil)  
    expect(delete.code).to eq(405)
    expect(delete.message).to eq("Method Not Allowed")
    expect(delete.content_type).to eq("text/html")
  end
end
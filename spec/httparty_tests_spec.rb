require 'httparty'
require 'spec_helper'
$LOAD_PATH << '.'
require "todos_module"


describe "Test Suite sends a post request" do
  it "should create a new post in collection" do
     #execute
      r= HTTParty.post "http://lacedeamon.spartaglobal.com/todos", query:{title: "An Item", due: "2015-01-01"}
     #verify
      expect(r["title"]).to eq("An Item")
	    expect(r.code).to eq(201)
      expect(r['due']).to eq("2015-01-01")
    #teardown
      TodosUtil.delete(r['id'])
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
end

describe "Test Suite sends a get request" do
  it "should read/get the hash at a specific ID" do
      id = TodosUtil.post
      r= HTTParty.get "http://lacedeamon.spartaglobal.com/todos/#{id}"
      expect(r["title"]).to eq("An Item")
      expect(r.code).to eq(200)
      expect(r['due']).to eq("2015-01-01")
      #teardown
      TodosUtil.delete(r['id'])
  end
  it "should return an empty hash from an empty ID" do
      r= HTTParty.get "http://lacedeamon.spartaglobal.com/todos/00"
      expect(r.code).to eq(404)
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
    r= HTTParty.put "http://lacedeamon.spartaglobal.com/todos/#{id}", query:{title: "Changed An Item to Another Item", due: "2015-01-01"}
    expect(r["title"]).to eq("Changed An Item to Another Item")
    expect(r["id"]).to eq(id)
    expect(r.code).to eq(200)
    expect(r['due']).to eq("2015-01-01")
    #teardown
    TodosUtil.delete(r['id'])
  end
end

describe "Test Suite sends a patch request" do
  it "should" do
       r= HTTParty.get "http://lacedeamon.spartaglobal.com/todos"
       r.each {|s|
         HTTParty.delete "http://lacedeamon.spartaglobal.com/todos/#{r["id"]}" if r["title"] == "D4Y"}
  end
end

describe "Test suite sends a delete request" do
  it "should delete a single todo" do

  end
  
  it "should not delete todo collection" do

  end
  
  it "should not delete todo collection" do

  end
end
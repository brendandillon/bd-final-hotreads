require 'rails_helper'

RSpec.describe "Links controller" do
  it "recieves a link" do
    payload = JSON.generate(url: 'http://turing.io')

    post '/links', 
      params: payload,
      headers: {'Content-Type': 'application/json'}

    expect(response.status).to eq(201)
    expect(Link.last.url).to eq('http://turing.io')
  end

  it "increments an existing link" do
    Link.create(url: 'http://turing.io', count: 1)
    payload = JSON.generate(url: 'http://turing.io')

    post '/links', 
      params: payload,
      headers: {'Content-Type': 'application/json'}

    expect(response.status).to eq(201)
    expect(Link.last.count).to eq(2)
  end

  it "returns a JSON object of hot links" do
    Link.create(url: 'http://turing.io', count: 1)

    get '/links.json'

    expected = Link.all.to_json
    expect(response.body).to eq(expected)
  end
end

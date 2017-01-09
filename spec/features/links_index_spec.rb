require 'rails_helper'

RSpec.describe "Links index" do
  it "shows submitted links" do
    Link.create(url: 'http://turing.io', count: 1)

    visit '/'
    expect(page).to have_content('http://turing.io')
  end

  it "only shows the top 10" do
    11.times do |i|
      Link.create(url: "http://#{i}.com", count: 1)
    end

    visit '/'
    expect(page).to have_css('li', count: 10)
  end

  it "shows the most popular first" do
    Link.create(url: 'http://1.com', count: 1)
    Link.create(url: 'http://3.com', count: 3)
    Link.create(url: 'http://2.com', count: 2)

    visit '/'
    within ('li:first-of-type') do
      expect(page).to have_content('http://3.com')
    end
  end
end

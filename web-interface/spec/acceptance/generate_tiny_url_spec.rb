require "rails_helper"

RSpec.describe "Tiny Url Generation", :type => :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it "provides a form to shorten the target url" do
    visit short_urls_path

    fill_in "url", :with => "https://www.linkedin.com/in/orbanbotond"
    click_button "Shorten"

    expect(page).to have_text("Your shortened url:")
    expect(page).to have_text("http://tny.cm/")
  end

  it "provides a form to decode the shortened url" do
    shortener = UrlShortener::Api.new('http://tny.cm')
    link = "https://www.linkedin.com/in/orbanbotond"
    shortened_url = shortener.encode link
    visit short_urls_path

    fill_in "shortened_url", :with => shortened_url
    click_button "Decode"

    expect(page).to have_text("Original url:")
    expect(page).to have_text(link)
  end
end
require "rails_helper"

RSpec.describe "Tiny Url Generation", :type => :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it "provides a form to shorten the target url" do
    visit "/"

    fill_in "url", :with => "https://www.linkedin.com/in/orbanbotond"
    click_button "Shorten"

    expect(page).to have_text("Shortened url:")
    expect(page).to have_text("http://tny.cm/")
  end
end
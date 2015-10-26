require 'spec_helper'
require 'rails_helper'
require 'bcrypt'

feature 'Comments About User' do
  before :each do
    visit "/users/new"
    fill_in "Username", with: "test1"
    fill_in "Password", with: "whatever"
    click_button "Submit"
    click_button "Log Out"
    visit "/users/new"
    fill_in "Username", with: "test2"
    fill_in "Password", with: "whatever"
    click_button "Submit"
  end

  scenario "Posting a User Comment" do
    click_on "All Users"
    click_on "test1"
    fill_in "Body", with: "UserComment1"
    click_button "Submit"
    expect(page).to have_content "UserComment1"
  end

  scenario "User cannot comment about own self" do
    visit "/users/2"
    fill_in "Body", with: "UserComment1"
    click_button "Submit"
    expect(page).to have_content "Author can't write comment about self"
  end





end

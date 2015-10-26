require 'spec_helper'
require 'rails_helper'
require 'bcrypt'

feature "Sign Up" do
  before :each do
    visit "/users/new"
  end

  scenario "user signup page" do
    expect(page).to have_content "Sign Up"
    expect(page).to have_content "Username"
    expect(page).to have_content "Password"
  end

  scenario "validates the presence of a Username" do
    fill_in "Password", with: "whatever"
    click_button "Submit"
    expect(page).to have_content "Username can't be blank"
  end

  scenario "validates that Password is at least 6 characters" do
    fill_in "Username", with: "whatever"
    click_button "Submit"
    expect(page).to have_content "Password is too short (minimum is 6 characters)"
  end

  scenario "logs the user in and redirects them to goals" do
    fill_in "Username", with: "whatever"
    fill_in "Password", with: "whatever"
    click_button "Submit"
    expect(page).to have_content "All Goals"
  end
end

feature "Sign In / Sign Out" do
  before :each do
    visit "/users/new"
    fill_in "Username", with: "whatever"
    fill_in "Password", with: "whatever"
    click_button "Submit"
  end

  scenario "There's a sign out button when signed in" do
    expect(page).to have_button "Log Out"
  end

  scenario "Users can sign in after signing out" do
    click_button "Log Out"
    fill_in "Username", with: "whatever"
    fill_in "Password", with: "whatever"
    click_button "Submit"
    expect(page).to have_content "All Goals"
    expect(page).to have_button "Log Out"
  end

  scenario "There are Login and Sign Up links when not signed in" do
    click_button "Log Out"
    expect(page).to have_content "Login"
    expect(page).to have_content "Sign Up"
    expect(page).to_not have_content "Log Out"
  end

  scenario "User cannot access goals unless signed in" do
    expect(page).to have_content "All Goals"
    click_button "Log Out"
    visit "/goals"
    expect(page).to have_content "Sign In"
    expect(page).not_to have_content "All Goals"
  end


end

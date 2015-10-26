require 'spec_helper'
require 'rails_helper'
require 'bcrypt'


feature "Goals" do
  before :each do
    visit "/users/new"
    fill_in "Username", with: "Name123"
    fill_in "Password", with: "123123"
    click_button "Submit"
    click_on "New Goal"
    fill_in "Title", with: "Title1"
    fill_in "Content", with: "Content1"
  end

  scenario "Users can create goals" do
    choose('True')
    expect(page).to_not have_content "Title can't be blank"
    expect(page).to_not have_content "Content can't be blank"
    expect(page).to_not have_content "Privacy can't be blank"
    click_button "Submit"
    expect(page).to have_content "Title1"
    expect(page).to have_content "Content1"
  end

  scenario "validates presence of all fields" do
    choose('True')
    click_button "Submit"
    visit "/goals/new"
    click_button "Submit"
    expect(page).to have_content "Title can't be blank"
    expect(page).to have_content "Content can't be blank"
    expect(page).to have_content "Privacy can't be blank"
  end

  scenario "Forms are pre filled when creation fails" do
    click_button "Submit"
    expect(page.body).to include("goaltitle")
    expect(page).to have_content "Content1"
    expect(page).to have_content "Privacy can't be blank"
  end

  scenario "Goals can be deleted" do
    choose('True')
    click_button "Submit"
    click_button "Delete"
    expect(page).to have_content "All Goals"
    expect(page).to_not have_content "Title1"
  end

  scenario "Other users cannot see private goals" do
    choose('True')
    click_button "Submit"
    click_button "Log Out"
    visit "/users/new"
    fill_in "Username", with: "Name12"
    fill_in "Password", with: "123123"
    click_button "Submit"
    expect(page).to_not have_content "Title1"
    visit "/goals/1"
    expect(page).to have_content "All Goals"
  end

  scenario "Users can edit their own goals with prefilled forms" do
    choose('True')
    click_button "Submit"
    click_on "Edit"
    expect(page.body).to include "Title1"
    expect(page.body).to include "checked"

  end

  scenario "Users cannot edit other's goals" do
    choose('False')
    click_button "Submit"
    click_button "Log Out"
    visit "/users/new"
    fill_in "Username", with: "Name12"
    fill_in "Password", with: "123123"
    click_button "Submit"
    visit "/goals/1/edit"
    expect(page).to have_content "All Goals"
    expect(page).to_not have_content "Content1"

  end

end

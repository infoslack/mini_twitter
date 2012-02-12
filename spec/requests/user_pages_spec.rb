require 'spec_helper'

describe "User Pages" do

  subject { page }

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_selector('h1',     text: user.name) }
    it { should have_selector('title',  text: user.name) }
  end

  describe "signup" do

    before { visit signup_path }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Sign up" }.not_to change(User, :count)
      end
    end

    describe "error_messages" do
      before { click_button "Sign up" }

      let(:error) { 'errors prohibited this user from being saved' }

      it { should have_selector('title', text: 'Sign up') }
      it { should have_content(error) }
    end

    describe "with valid information" do
      before do
        fill_in "Name",           with: "User Teste"
        fill_in "Email",          with: "teste@domain.com"
        fill_in "Password",       with: "teste123"
        fill_in "Confirmation",   with: "teste123"
      end

      describe "after saving the user" do
        before { click_button "Sign up" }
        let(:user) { User.find_by_email('teste@domain.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.flash.success', text: 'Welcome') }
      end

      it "should create a user" do
        expect { click_button "Sign up" }.to change(User, :count).by(1)
      end
    end
  end
end

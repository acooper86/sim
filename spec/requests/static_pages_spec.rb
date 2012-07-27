require 'spec_helper'

describe "Static Pages" do
  describe "Home Page" do
    it "should have Simplissage title" do
      get root_path
      response.status.should be(200)
      page.should have_content('Simplissage')
    end
  end
end

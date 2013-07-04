require "spec_helper"

describe "Profiles" do

  describe "when I visit a persons profile" do

    describe "when the entity exists" do
      it "shows the page" do
        visit "/profiles/David_Cameron"
        expect(page).to have_content('David Cameron')
      end
    end

    describe "when the entity has periods in their name" do
      it "shows the page" do
        visit "/profiles/Arsenal_F.C."
        expect(page).to have_content('Arsenal F.C.')
      end
    end

    describe "when the entity has encoded periods in their name" do
      it "shows the page" do
        visit "/profiles/Swansea_City_A%2EF%2EC%2E"
        expect(page).to have_content('Swansea City A.F.C.')
      end
    end

    describe "when the person does not exist" do
      it "shows the 404 page" do
        visit "/profiles/this-does-not-exist"
        expect(page).to have_content('404')
      end
    end
  end

  describe "when I visit a person's news RSS feed" do
    before do
      visit "/profiles/David_Cameron/read.rss"
    end
    
    it "shows the news feed" do
      expect(page).to have_content('BBC People - News Feed')
    end
  end
end

require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET /categories" do
    it "has no index page" do
      category = create :category
      get edit_category_path(id: category.id)
      expect(response).to have_http_status(302)
    end
  end
end

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # Category. As you add validations to Categories, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { name: 'valid_category' }
  }

  let(:invalid_attributes) {
    {name: nil }
  }

  before do
    allow(controller).to receive(:authenticate_user!).and_return true
    allow(controller).to receive(:ensure_admin!).and_return true
  end

  describe "GET #show" do
    it "assigns the requested categories as @category" do
      category = create :category
      get :show, id: category.id, category: valid_attributes
      expect(assigns(:category)).to eq(category)
    end
  end

  describe "GET #new" do
    it "assigns a new categories as @category" do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe "POST #create" do
      context "with valid params" do
      it "creates a new Categories" do
        expect {
          post :create, category: valid_attributes
        }.to change(Category, :count).by(1)
      end

      it "assigns a newly created categories as @category" do
        post :create, category: valid_attributes
        expect(assigns(:category)).to be_a(Category)
        expect(assigns(:category)).to be_persisted
      end

      it "redirects to the created category" do
        post :create, category: valid_attributes
        expect(response).to redirect_to(Category.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved categories as @category" do
        post :create, category: invalid_attributes
        expect(assigns(:category)).to be_a_new(Category)
      end

      it "re-renders the 'new' template" do
        post :create, category: invalid_attributes
        expect(response).to render_template("new")
      end
    end
  end
end
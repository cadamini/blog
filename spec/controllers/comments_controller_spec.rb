require "rails_helper"

RSpec.describe CommentsController do

  describe "GET #new" do
    it "assigns a home, office, and mobile phone to the new contact" do
      get :new, params: { post_id: 1 }
      expect(assigns(:comment)).to be_a_new Comment
    end
  end

  describe "POST create" do

    before :each do 
      @post = create :post
    end

    context "with valid attributes" do

      it "creates a new comment" do
        expect{
          post :create, params: { post_id: @post.id, comment: FactoryGirl.attributes_for(:comment) }
        }.to change(Comment,:count).by(1)
        expect(flash[:notice]).to eq "Comment successfully created"
      end
      
      it "redirects to the new comment" do
        post :create, params: { post_id: @post.id, comment: FactoryGirl.attributes_for(:comment) }
        response.should redirect_to post_url(@post)
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new comment" do
        expect{
          post :create, params: { post_id: @post.id, comment: FactoryGirl.attributes_for(:invalid_comment) }
        }.to_not change(Comment,:count)
        expect(flash[:error]).to eq "Comment creation failed"
      end
      
      it "re-renders the new method" do
        post :create, params: { post_id: @post.id, comment: FactoryGirl.attributes_for(:invalid_comment) }
        expect(response).to redirect_to post_url(@post.id)
      end
    end 
  end

  describe 'DELETE destroy' do

    before :each do
      @post = create :post
      @comment = create :comment
      allow(controller).to receive(:authenticate_user!).and_return true
      allow(controller).to receive(:ensure_admin!).and_return true
    end
    
    it "deletes the comment" do
      expect{
        delete :destroy, params: { post_id: @post.id, id: @comment         }
      }.to change(Comment,:count).by(-1)
      expect(flash[:notice]).to eq "Comment successfully deleted"
    end

    it 'fails to delete a comment' do 

      item = double
      allow(Comment).to receive(:find).and_return(item)
      allow(item).to receive(:destroy).and_return(false)
      delete :destroy, params: { post_id: @post.id, id: @comment }
      expect(flash[:error]).to eq "Problem while deleting comment"
    end

    it "redirects to post show" do
      delete :destroy, params: { post_id: @post.id, id: @comment }
      response.should redirect_to post_url(@post)
    end
  end
end
require "rails_helper"

RSpec.describe PostsController do
	
	describe '#admin' do 
		before do	
			allow(controller).to receive(:authenticate_user!).and_return true
			allow(controller).to receive(:ensure_admin!).and_return true
			@post = create :post, title: "John John", description: "Doe Doe"
		end

		it 'renders the index template' do 
			get :index
			expect(response).to have_http_status :ok
			expect(subject).to render_template(:index)
		end

		it 'shows published posts on index' do
			get :index
			post = create :post, published: true, category_id: nil
			expect(assigns(:posts)).to eq [post]
		end

		it 'does not unpublished posts on index' do
			get :index
			expect(assigns(:posts)).to eq []
		end

		it 'renders the edit template' do
			get :edit, params: { id: @post.id }
			expect(subject).to render_template(:edit)
			expect(response).to have_http_status :ok
			expect(assigns(:post)).to eq @post
		end

		it 'renders the new template for authenticated admin user' do 
			get :new
			expect(subject).to render_template(:new)
			expect(response).to have_http_status :ok
			expect(assigns(:post)).to be_a_new(Post)
		end

		it "creates a new post" do
			expect { post :create, params: { post: FactoryGirl.attributes_for(:post) } }.to change(Post,:count).by(1)
			expect(response).to redirect_to admin_index_path
			expect(flash[:notice]).to eq "Post successfully created."
		end

		it 'fails to create a post' do 
			post :create, params: { post: {title: nil, description: nil} }
			expect(flash[:error]).to eq 'Post creation failed.'
			expect(subject).to render_template(:new)
		end

		# invalid post 
		# count does not change
		# rerenders new template

		it 'deletes a post' do 
			expect { delete :destroy, params: { id: @post } }.to change(Post,:count).by(-1)
			expect(flash[:notice]).to eq 'Post successfully deleted.'
		end

		it "fails to delete a post" do 
			allow(Post).to receive(:find).and_return(@post)
			allow(@post).to receive(:destroy).and_return(false)
			delete :destroy, params: { id: @post }
			expect(flash[:error]).to eq 'Post deletion failed.'
			expect(response).to redirect_to admin_index_path
		end

		it "redirects to posts#index" do
			delete :destroy, params: { id: @post }
			expect(response).to redirect_to admin_index_path
		end

		it 'updates the description attribute' do 
			@post.description = 'new_description'
			put :update, params: { id: @post, post: FactoryGirl.attributes_for(:post, description:  'new_description') }
			@post.reload
			expect(@post.description).to eq 'new_description'
		end

		it 'fails to update a post' do			
			put :update, params: { id: @post.id, post: {description: nil} }
			expect(flash[:error]).to eq 'Post update failed.'
			expect(response).to redirect_to @post
		end

		it 'redirects to the same post' do 
			@post.description = 'new_description'
			put :update, params: { id: @post, post: FactoryGirl.attributes_for(:post) }
			expect(subject).to redirect_to @post
		end

		#invalid attributes
		# -> locates the requested
		# -> does not change attributes
		# re-renders the edit method

	end

	describe '#normal users' do

		before do
			allow(controller).to receive(:authenticate_user!).and_return false
			allow(controller).to receive(:ensure_admin!).and_return false
		end

		it 'does not render the edit template for authenticated normal user' do
			expect(subject).to_not render_template(:edit)
			expect(response).to have_http_status :ok
		end

		it 'does not render the new template for authenticated normal user' do
			expect(subject).to_not render_template(:new)
			expect(response).to have_http_status :ok
		end

		it 'renders the show template' do 
			category = create :category
			post = create :post, category_id: category.id
			get :show, params: { id: post.id }
			expect(response).to have_http_status :ok
			expect(assigns(:post)).to eq post
			expect(assigns(:category)).to eq 'new_category'
		end

		it 'shows none if no category is set' do
			post = create :post, category_id: nil
			get :show, params: { id: post.id }
			expect(assigns(:category)).to eq 'none'
		end
	end
end
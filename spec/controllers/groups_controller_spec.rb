require 'rails_helper'

RSpec.describe GroupsController, type: :request do
  let(:user) { create(:user) }
  let!(:group) { create(:group, user_id: user.id) }

  before { sign_in user }

  describe 'GET #index' do
    it 'displays the categories' do
      get user_groups_path(user)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(group.name)
    end

    it 'displays the categories whose name starts with the query' do
      create(:group, user_id: user.id, name: 'Test Group')
      get user_groups_path(user, params: { query: 'Test' })
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Test Group')
    end
  end

  describe 'GET #show' do
    it 'displays the category' do
      get user_group_path(user, group)
      expect(response).to have_http_status(:success)
      expect(response.body).to include(group.name)
    end
  end

  describe 'GET #edit' do
    it 'displays the form to edit the category' do
      get edit_user_group_path(user, group)
      expect(response).to have_http_status(:success)
      expect(response.body).to include('Edit category')
    end
  end

  describe 'PUT #update' do
    let(:new_name) { 'New category name' }

    it 'updates the category' do
      put user_group_path(user, group), params: { group: { name: new_name } }
      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(user_group_path(user, group))
      expect(group.reload.name).to eq(new_name)
    end
  end

  describe 'GET #new' do
    it 'displays the form to create a new category' do
      get new_user_group_path(user)
      expect(response).to have_http_status(:success)
      expect(response.body).to include('New category')
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the category' do
      expect do
        delete user_group_path(user, group)
      end.to change(Group, :count).by(-1)

      expect(response).to have_http_status(:redirect)
      expect(response).to redirect_to(user_groups_path(user))
      expect(flash[:notice]).to eq('Group was successfully deleted!')
    end
  end
end

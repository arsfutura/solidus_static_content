require 'spec_helper'

describe Spree::StaticContentController do
  before do
    controller.stub spree_current_user: nil
  end

  let!(:store) { create(:store, default: true) }

  context '#show' do
    it 'accepts path as root' do
      page = create(:page, slug: '/', stores: [store])
      allow_any_instance_of(controller.request.class).to receive(:path) { page.slug }
      get :show, params: { path: page.slug }
      expect(response).to be_success
    end

    it 'accepts path as string' do
      page = create(:page, slug: 'hello', stores: [store])
      allow_any_instance_of(controller.request.class).to receive(:path) { page.slug }
      get :show, params: { path: page.slug }
      expect(response).to be_success
    end

    it 'accepts path as nested' do
      page = create(:page, slug: 'aa/bb/cc', stores: [store])
      allow_any_instance_of(controller.request.class).to receive(:path) { page.slug }
      get :show, params: { path: page.slug }
      expect(response).to be_success
    end

    it 'respond with a 404 when no page exists' do
      get :show
      expect(response.response_code).to eq(404)
    end
  end
end

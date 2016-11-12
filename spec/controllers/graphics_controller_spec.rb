require 'rails_helper'

describe GraphicsController, type: :controller do

  # describe 'GET index' do

  #   it 'assigns @graphics' do
  #     graphic = FactoryGirl.create(:graphic)
  #     get :index
  #     expect(assigns(:graphics)).to eq([graphic])
  #   end

  #   it 'renders the index template' do
  #     get :index
  #     expect(response).to render_template('index')
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe 'POST update' do

  #   it 'updates graphic attributes without associations' do
  #     graphic = FactoryGirl.create(:graphic)
  #     patch :update, :id => graphic.id, :graphic => FactoryGirl.attributes_for(:graphic,
  #                                       :description => 'description', :quantity => 5,
  #                                       :height => 18.3, :width => 9.2, :event_at => '2015-10-09',
  #                                       :note => 'notes', :hardware_type => 'hardware_type',
  #                                       :hardware_price => 12.5)
  #     graphic.reload
  #     expect(graphic.description).to eq 'description'
  #     expect(graphic.quantity).to eq 5
  #     expect(graphic.height).to eq 18.3
  #     expect(graphic.width) == 9.2
  #     expect(graphic.event_at).to eq Date.parse('2015-10-09')
  #     expect(graphic.note).to eq 'notes'
  #     expect(graphic.hardware_type).to eq 'hardware_type'
  #     expect(graphic.hardware_price).to eq 12.5
  #   end

  #   # This test is failing. Adding any kind of info to Side, Graphic Type, etc. will throw error
  #   it 'updates graphic attributes with associations' do
  #     graphic = FactoryGirl.create(:graphic)
  #     patch :update, :id => graphic.id, :graphic => FactoryGirl.attributes_for(:graphic,
  #                                       :side_id => 3, :substrate_id => 4, :graphic_type_id => 5,
  #                                       :workflow_status_id => 1)
  #     graphic.reload
  #     expect(graphic.side_id).to eq 3
  #     expect(graphic.substrate_id).to eq 4
  #     expect(graphic.graphic_type_id).to eq 5
  #     expect(graphic.workflow_status_id).to eq 1
  #   end
  # end
end
require 'rails_helper'

describe WelcomeController, type: :controller do
  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
    xit 'assigns @fieldNote' do
      field_note = FieldNote.create
      get :index
      expect(assigns(:field_note)).to eq([field_note])
    end
  end
end

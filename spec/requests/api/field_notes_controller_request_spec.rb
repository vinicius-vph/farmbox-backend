require 'rails_helper'

describe 'Api/V1/FieldNotesController', type: :request do
  context 'GET' do
    it 'field_note index success' do
      field_note = FieldNote.create(long_text: 'Essa é uma nota do campo, talhão 1', user: '1',
                                    date: Time.new, latitude: '-22.908333', longitude: '-43.196388')

      get 'http://localhost:3000/api/v1/field_notes/'

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(JSON.parse(response.body).size).to eq(1)
      expect(response.body).to include(field_note.long_text)
      expect(response.body).to_not include('created_at')
    end
    it 'field_note show success' do
      field_note = FieldNote.create(long_text: 'Essa é uma nota do campo, talhão 1', user: '1',
                                    date: Time.new, latitude: '-22.908333', longitude: '-43.196388')
      get "http://localhost:3000/api/v1/field_notes/#{field_note.id}"

      expect(JSON.parse(response.body).size).to eq(1)
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
    it 'field_note show fail' do
      field_note = FieldNote.create(long_text: 'Essa é uma nota do campo, talhão 1', user: '1',
                                    date: Time.new, latitude: '-22.908333', longitude: '-43.196388')
      get "http://localhost:3000/api/v1/field_notes/#{field_note.id * 10}"

      expect(response).to have_http_status(:not_found)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response.body).to include('Parâmetros inválidos')
    end
  end

  context 'PATCH' do
    it 'field_note update success' do
      field_note = FieldNote.create(long_text: 'Essa é uma nota do campo, talhão 1', user: '1',
                                    date: Time.new, latitude: '-22.908333', longitude: '-43.196388')

      patch "http://localhost:3000/api/v1/field_notes/#{field_note.id}",
            params: { field_note: { long_text: 'Nota atualizada' } }

      expect(response).to have_http_status(:success)
      expect(response.body).to include('Nota atualizada')
      expect(response.body).to include(field_note.latitude)
    end
    it 'field_note update data fail' do
      field_note = FieldNote.create(long_text: 'Essa é uma nota do campo, talhão 1', user: '1',
                                    date: Time.new, latitude: '-22.908333', longitude: '-43.196388')

      patch "http://localhost:3000/api/v1/field_notes/#{field_note.id}", params: { field_note: { long_text: '' } }

      expect(response).to have_http_status(:unprocessable_entity)
      # expect(response.body).to include('Não podeficar em branco')
    end
    it 'field_note not found for update' do
      field_note = FieldNote.create(long_text: 'Essa é uma nota do campo, talhão 1', user: '1',
                                    date: Time.new, latitude: '-22.908333', longitude: '-43.196388')

      patch "http://localhost:3000/api/v1/field_notes/#{field_note.id*100}",
                                    params: { field_note: { long_text: 'Nota atualizada' } }

      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('Parâmetros inválidos')
    end
  end

  context 'POST' do
    it 'field_note create success' do
      post 'http://localhost:3000/api/v1/field_notes', params: { field_note:{ long_text: 'Essa é uma nota do campo, talhão 1',
                                                                              user: '1', date: Time.new, latitude: '-22.908333',
                                                                              longitude: '-43.196388' } }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body).size).to eq(1)
    end
    it 'field_note create fail' do
      post 'http://localhost:3000/api/v1/field_notes', params: { field_note: { long_text: '' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'field_note delete success' do
      field_note = FieldNote.create(long_text: 'Essa é uma nota do campo, talhão 1', user: '1',
                                    date: Time.new, latitude: '-22.908333', longitude: '-43.196388')
      delete "http://localhost:3000/api/v1/field_notes/#{field_note.id}"

      expect(response).to have_http_status(:no_content)
      expect(response.body.size).to eq(0)
    end
    it 'field_note delete fail' do
      delete 'http://localhost:3000/api/v1/field_notes/field_note.id'

      expect(response).to have_http_status(:not_found)
    end
  end
end

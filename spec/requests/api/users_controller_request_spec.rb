require 'rails_helper'

describe 'Api/V1/UsersController', type: :request do
  context 'GET' do
    it 'user show success' do
      user = User.create(email: 'jonh@doe.com', password: '123456789')
      get "http://localhost:3000/api/v1/users/#{user.id}"

      expect(JSON.parse(response.body).size).to eq(2)
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')
      expect(response.body).to include('Usuário encontrado com sucesso')
      expect(response.body).to_not include('password')
    end
    it 'user show fail' do
      user = User.create(email: 'jonh@doe.com', password: '123456789')
      get "http://localhost:3000/api/v1/users/#{user.id * 10}"

      expect(response).to have_http_status(:not_found)
    end
  end

  context 'PATCH' do
    it 'user update success' do
      user = User.create(email: 'jonh@doe.com', password_digest: '123456789')

      patch "http://localhost:3000/api/v1/users/#{user.id}", params: { user: { email: 'teste@teste.com' } }

      expect(response).to have_http_status(:success)
      expect(response.body).to_not include('password')
      expect(response.body).to include('Usuário atualizado com sucesso')
      expect(response.body).to include('teste@teste.com')
    end
    it 'user update fail' do
      user = User.create(email: 'jonh@doe.com', password_digest: '123456789')

      patch "http://localhost:3000/api/v1/users/#{user.id}", params: { user: { email: '' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'POST' do
    it 'user create success' do
      post 'http://localhost:3000/api/v1/users', params: { user: { email: 'jonh@doe.com',
                                                                   password_digest: '123456789' } }

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body).size).to eq(2)
      expect(response.body).to_not include('password')
      expect(response.body).to include('Usuário criado com sucesso')
    end
    it 'user create fail' do
      post 'http://localhost:3000/api/v1/users', params: { user: { email: 'jonh@doe.com', password: '' } }

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  context 'DELETE' do
    it 'user delete success' do
      user = User.create(email: 'jonh@doe.com', password: '123456789')
      delete "http://localhost:3000/api/v1/users/#{user.id}"

      expect(response).to have_http_status(:no_content)
      expect(response.body.size).to eq(0)
    end
    it 'user delete fail' do
      delete 'http://localhost:3000/api/v1/users/user.id'

      expect(response).to have_http_status(:not_found)
    end
  end
end

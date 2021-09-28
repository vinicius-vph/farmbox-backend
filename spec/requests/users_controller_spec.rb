require 'rails_helper'

describe 'User', :type => :request do
  it 'Get page' do
    get '/users/new'
    expect(response).to have_http_status(:success)
  end
end

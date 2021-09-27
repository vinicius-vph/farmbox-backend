require 'rails_helper'

describe 'routes for Welcomepage', type: :routing do
  it 'routes /welcome to the welcome controller' do
    expect(get('/welcome')).to route_to('welcome#index')
  end
end

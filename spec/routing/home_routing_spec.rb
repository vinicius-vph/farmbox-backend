require 'rails_helper'

describe 'routes for Homepage', type: :routing do
  it 'routes / to the home controller' do
    expect(get('/')).to route_to('home#index')
  end
end

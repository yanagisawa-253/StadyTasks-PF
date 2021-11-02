# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end
  describe 'お問合せ機能' do
    
  end
end
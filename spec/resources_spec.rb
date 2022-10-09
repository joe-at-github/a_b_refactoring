# frozen_string_literal: true

require_relative './spec_helper'

RSpec.describe 'resources' do
  describe 'product' do
    let(:application_a_object) { YAML.safe_load(fixture('a/product.yml').read) }
    let(:application_b_object) { YAML.safe_load(fixture('b/product.yml').read) }

    it 'generate the same attributes' do
      expect(application_a_object).to eq application_b_object
    end
  end

  describe 'provider' do
    let(:application_a_object) { YAML.safe_load(fixture('a/provider.yml').read) }
    let(:application_b_object) { YAML.safe_load(fixture('b/provider.yml').read) }

    it 'generate the same attributes' do
      expect(application_a_object).to eq application_b_object
    end
  end
end

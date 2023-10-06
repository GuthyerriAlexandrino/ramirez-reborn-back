# frozen_string_literal: true

require 'rails_helper'

describe SpecializationService do
  context 'Get Specialization' do
    it 'Get a existent specialization' do
      test_specialization = Specialization.new(name: 'Fotografia animal')
      db = double('Fotografia animal')
      allow(db).to receive(:all).and_return(test_specialization)
      post = double(name: db)


      speciali = SpecializationService.get_specialization('Fotografia animal')

      expect(speciali).to eq(test_specialization)
    end
  end
end 

require 'rails_helper'

RSpec.describe Post do
    it { is_expected.to be_mongoid_document }
  
    it { is_expected.to have_field(:title).of_type(String) }
    it { is_expected.to have_field(:image).of_type(String) }
    it { is_expected.to have_field(:price).of_type(Float) }
  
    it { is_expected.to validate_length_of(:title).within(1..160) }
    it { is_expected.to validate_numericality_of(:price).allow_nil.is_greater_than(0) }
  
    it { is_expected.to be_embedded_in(:user) }
    it { is_expected.to embed_many(:likes) }
    it { is_expected.to have_many(:comments) }
  end
  
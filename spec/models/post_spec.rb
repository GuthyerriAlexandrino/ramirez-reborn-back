RSpec.describe Post do
    it { is_expected.to be_mongoid_document }
  
    it { is_expected.to have_field(:title).of_type(String) }
    it { is_expected.to have_field(:image).of_type(String) }
    it { is_expected.to have_field(:price).of_type(Float) }
  end
  
require 'spec_helper'

describe Company do
  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "Associations" do
    it { should have_many(:users) }
  end
end

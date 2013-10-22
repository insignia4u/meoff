require 'spec_helper'

describe User do
  describe "Associations" do
    it { should belong_to(:company) }
    it { should have_many(:notifications) }
  end

  describe "Validations" do
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:company) }
  end

  describe "Behaviors" do
    it { should accept_nested_attributes_for(:company) }
  end

  describe "Factory validation" do
    it "creates a valid user" do
      expect { create(:user) }.to change { User.count }.by(1)
    end

    it "creates a valid company" do
      expect { create(:user) }.to change { Company.count }.by(1)
    end
  end

  describe "Company creation through nested attribute" do
    context "with valid attributes" do
      let(:valid_user_attributes) {
        attributes_for(
          :user, company: nil, company_attributes: attributes_for(:company)
        )
      }

      it "creates a valid company" do
        expect {
          User.create(valid_user_attributes)
        }.to change { Company.count }.by(1)
      end

      it "associates that company with the user" do
        User.create(valid_user_attributes)
        expect(User.last.company).to eql(Company.last)
      end
    end

    context "with invalid attributes" do
      let(:invalid_user_attributes) {
        attributes_for(
          :user, company: nil, company_attributes: { name: nil }
        )
      }

      it "doesn't create a empty company" do
        expect {
          User.create(invalid_user_attributes)
        }.not_to change { Company.count }.by(1)
      end
    end
  end
end

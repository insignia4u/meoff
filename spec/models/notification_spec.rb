require 'spec_helper'

describe Notification do
  describe "Associations" do
    it { should belong_to(:user) }
    it { should belong_to(:company) }
  end

  describe "Validations" do
    it { should validate_presence_of(:reason) }
    it { should validate_presence_of(:scheduled_on) }
  end

  describe "Factory validation" do
    it "creates a valid notification" do
      expect { create(:notification) }.to change { Notification.count }.by(1)
    end
  end
end

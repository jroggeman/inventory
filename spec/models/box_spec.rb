require 'rails_helper'

RSpec.describe Box, type: :model do
  let :box do
    build :box
  end

  subject do
    box
  end

  it "should have a name" do
    expect(box).to validate_presence_of :name
  end
end

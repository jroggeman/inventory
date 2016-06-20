require 'rails_helper'

RSpec.describe User, type: :model do
  let :user do
    build :user
  end

  subject do
    user
  end

  it "should have an email" do
    expect(user).to validate_presence_of :email
  end

  it "should have a unique email" do
    expect(user).to validate_uniqueness_of :email
  end

  it "should have a secure password" do
    expect(user).to have_secure_password
  end

  it "should have a name" do
    expect(user).to validate_presence_of :name
  end

  it "should have a password" do
    expect(user).to validate_presence_of :password_digest
  end
end


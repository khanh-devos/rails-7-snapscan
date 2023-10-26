require 'rails_helper'

RSpec.describe User do
  subject { User.create(
    name: 'John', 
    email: 'john@gmail.com', 
    password: '@manda123'
    ) }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'email should be present' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'should have many groups' do
    assc = described_class.reflect_on_association(:groups)
    expect(assc.macro).to eql :has_many
  end

  it 'should have many expenses' do
    assc = described_class.reflect_on_association(:expenses)
    expect(assc.macro).to eq :has_many
  end

end

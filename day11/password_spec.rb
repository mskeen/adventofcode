require_relative('./password.rb')

describe 'password' do
  it 'excludes the characters i, o, l' do
    expect(Password.new("hijklmmn")).to_not be_valid
  end

  it 'requires a straight of three characters' do
    expect(Password.new("abbceffg")).to_not be_valid
  end

  it 'requires two sets of double letters' do
    expect(Password.new("abbcegjk")).to_not be_valid
  end

  it 'is valid when all conditions are met' do
    expect(Password.new("abcdffaa")).to be_valid
  end

  it 'adds increments a single character for the next password' do
    expect(Password.new("aabbcdef").next).to eq "aabbcdeg"

  end

  it 'increments the password to the next valid password #1' do
    expect(Password.new("abcdefgh").next).to eq "abcdffaa"
  end

  it 'increments the password to the next valid password #2' do
    expect(Password.new("ghijklmn").next).to eq "ghjaabcc"
  end
end

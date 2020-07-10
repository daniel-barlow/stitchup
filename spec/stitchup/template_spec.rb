require 'stitchup/template'

RSpec.describe Stitchup::Template do
  it "parses from a hash-like collection of attributes" do
    input = {
      source: "https://example.com/foo",
      fields: {
        "name" => "fred",
        "number" => "ABCD1001XB",
        "total" => "123.45"
      }
    }
    parse_result = Stitchup::Template.parse(input)
    expect(parse_result).to be_successful
    expect(parse_result.value).to be_a Stitchup::Template
    expect(parse_result.value.source).to be_a URI::HTTPS
  end

  it "provides meaningful failure message for invalid data" do
    input = {
      source: "http//example.com/foo",
      fields: {
        "name" => "fred",
        "number" => "ABCD1001XB",
        "total" => "123.45",
        "6 * 9" => 42
      }
    }
    parse_result = Stitchup::Template.parse(input)
    expect(parse_result).not_to be_successful
    errors = parse_result.failure
    expect(errors).to have_key :source
    expect(errors[:fields].values)
      .to include({:message=>"value is not a string", :name=>"6 * 9"})
  end
end

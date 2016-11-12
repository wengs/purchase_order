require 'rails_helper'

RSpec.describe "milestones/show", type: :view do
  before(:each) do
    @milestone = assign(:milestone, Milestone.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end

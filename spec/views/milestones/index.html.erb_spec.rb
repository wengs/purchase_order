require 'rails_helper'

RSpec.describe "milestones/index", type: :view do
  before(:each) do
    assign(:milestones, [
      Milestone.create!(
        :name => "Name"
      ),
      Milestone.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of milestones" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end

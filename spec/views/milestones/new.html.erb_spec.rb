require 'rails_helper'

RSpec.describe "milestones/new", type: :view do
  before(:each) do
    assign(:milestone, Milestone.new(
      :name => "MyString"
    ))
  end

  it "renders new milestone form" do
    render

    assert_select "form[action=?][method=?]", milestones_path, "post" do

      assert_select "input#milestone_name[name=?]", "milestone[name]"
    end
  end
end

require 'rails_helper'

RSpec.describe "milestones/edit", type: :view do
  before(:each) do
    @milestone = assign(:milestone, Milestone.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit milestone form" do
    render

    assert_select "form[action=?][method=?]", milestone_path(@milestone), "post" do

      assert_select "input#milestone_name[name=?]", "milestone[name]"
    end
  end
end

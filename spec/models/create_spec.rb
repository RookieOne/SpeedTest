require "speed_spec_helper"

describe "create" do
  before do
    @blog = Blog.create(title: "New Blog")
  end
  it "should setup relation" do
    @blog.title.should == "New Blog"
  end
end
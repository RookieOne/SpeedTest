require "speed_spec_helper"

describe "create" do
  context "create" do
    before do
      @blog = Blog.create(title: "New Blog")
    end
    it "should setup relation" do
      @blog.title.should == "New Blog"

      Blog.count.should == 1
    end
  end
end
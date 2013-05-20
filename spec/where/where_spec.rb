require "speed_spec_helper"

describe "where" do
  context "where" do
    before do
      Blog.create(title: "New Blog")
      Blog.create(title: "New Blog")
      Blog.create(title: "Blog")

      @result = Blog.where(title: "New Blog")
    end
    it "should setup relation" do
      @result.count.should == 2      
    end
  end
end
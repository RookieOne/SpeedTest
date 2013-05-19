require "speed_spec_helper"

describe "has many" do
  before do
    @blog = Blog.create(title: "New Blog")

    @post = @blog.posts.create(title: "New Post")
  end
  it "should setup relation" do
    @blog.title.should == "New Blog"
    post = @blog.posts.first

    post.should_not be_nil
  end
end
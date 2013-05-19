require "speed_spec_helper"

describe "has many" do
  context "create" do
    before do
      @blog = Blog.create(title: "New Blog")

      @post = @blog.posts.create(title: "New Post")
    end
    it "should setup relation" do
      @blog.title.should == "New Blog"
      post = @blog.posts.first

      post.should_not be_nil

      Post.count.should == 1
      Blog.count.should == 1
    end  
  end
end
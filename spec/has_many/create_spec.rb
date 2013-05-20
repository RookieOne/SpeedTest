require "speed_spec_helper"

describe "has many" do
  context "create" do
    before do
      @blog = Blog.create(title: "New Blog")

      @post = @blog.posts.create(title: "New Post")
    end
    it "should setup relation" do
      Post.count.should == 1
      Blog.count.should == 1

      @blog.title.should == "New Blog"
      post = @blog.posts.first

      post.should_not be_nil
      post.blog.should == @blog   
    end  
  end
end
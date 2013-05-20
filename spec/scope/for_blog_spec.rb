require "speed_spec_helper"

describe "scope" do
  context "for_blog" do
    before do
      @blog = Blog.create(title: "New Blog")

      @post1 = @blog.posts.create(title: "New Post")
      @post2 = @blog.posts.create(title: "Post")

      @blog2 = Blog.create(title: "New Blog")

      @post3 = @blog.posts.create(title: "New Post")
      @post4 = @blog.posts.create(title: "Post")

      @result = Post.for_blog(@blog)
    end
    it "should setup relation" do
      @result.count.should == 2
    end
  end
end
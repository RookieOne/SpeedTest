require "speed_spec_helper"

describe "has many" do
  before do
    @blog = Blog.create(a)

    @post = @blog.posts.create(title: "New Post")
  end
  it "should setup relation" do


  end
end
class Post < ActiveRecord::Base
  belongs_to :blog
  attr_accessible :body, :title

  scope :for_blog, lambda { |blog| where(blog_id: blog.id) }
end

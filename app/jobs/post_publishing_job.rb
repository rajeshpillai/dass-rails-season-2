class PostPublishingJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    # length operation

    post = Post.new
    post.title = "Delayed job"
    post.description= "Testing delayed job"
    post.category = Category.first 

    post.save 

    sleep 3 

  end
end

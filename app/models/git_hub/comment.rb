module GitHub
  class Comment
    include Anima.new(:path, :line_number, :body)
  end
end

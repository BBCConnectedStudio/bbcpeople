class Person < Entity

  def image
    self.image_uri || "http://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Question_mark_3d.png/310px-Question_mark_3d.png"
  end

end

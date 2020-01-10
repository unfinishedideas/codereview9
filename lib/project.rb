require 'pry'

class Project
attr_reader :id
attr_accessor :title

def initialize(attributes)
  @title = attributes.fetch(:title)
  @id = attributes.fetch(:id)
end

def save
  result = DB.exec("INSERT INTO projects (title) VALUES ('#{@title}') RETURNING id;")
  @id = result.first().fetch("id").to_i
end

end

class Project
attr_reader :id
attr_accessor :title

def initialize(attributes)
  title = attributes.fetch("title")
end




end

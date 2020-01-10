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

  def ==(other_project)
    self.title().downcase.eql?(other_project.title().downcase())
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    id = project.fetch("id").to_i
    title = project.fetch("title")
    Project.new({:id => id, :title => title})
  end

  def update(attributes)
    if (attributes.has_key?(:title)) && (attributes.fetch(:title) != nil)
      @title = attributes.fetch(:title)
      DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id}")
    end
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{@id}")
    DB.exec("DELETE FROM volunteers * WHERE project_id = #{@id}")
  end

  def volunteers
    volunteer_query = DB.exec("SELECT * FROM volunteers WHERE project_id = #{@id}")
    volunteers = []
    volunteer_query.each do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id")
      project_id = @id
      volunteers.push(Volunteer.new({:name => name, :id => id, :project_id => project_id}))
    end
    volunteers
  end

end

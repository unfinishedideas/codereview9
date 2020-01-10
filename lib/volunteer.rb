class Volunteer
  attr_reader :id
  attr_accessor :name, :project_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def ==(other_volunteer)
    self.name().downcase.eql?(other_volunteer.name().downcase()) &&
    self.project_id.eql?(other_volunteer.project_id)
  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers;")
    volunteers = []
    returned_volunteers.each do |volunteer|
      name = volunteer.fetch("name")
      id = volunteer.fetch("id").to_i
      project_id = volunteer.fetch("project_id").to_i
      volunteers.push(Volunteer.new({:name => name, :id => id, :project_id => project_id}))
    end
    volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM volunteers WHERE id = #{id}").first
    name = result.fetch("name")
    id = result.fetch("id").to_i
    project_id = result.fetch("project_id").to_i
    volunteer = Volunteer.new({:id => id, :project_id => project_id, :name => name})
  end

end

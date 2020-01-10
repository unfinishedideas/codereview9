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
end

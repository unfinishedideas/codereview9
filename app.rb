require('sinatra')
require('sinatra/reloader')
require('./lib/volunteer')
require('./lib/project')
require('pry')
require("pg")
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  erb(:homepage)
end

get('/projects') do
  @projects = Project.all
  erb(:view_projects)
end

get('/volunteers') do
  @volunteers = Volunteer.all
  erb(:view_volunteers)
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id])
  erb(:edit_project)
end

get('/projects/:id/add') do
  @project = Project.find(params[:id])
  erb(:add_volunteer)
end

get('/volunteers/:id/edit') do
  @volunteer = Volunteer.find(params[:id])
  erb(:edit_volunteer)
end



post('/projects') do
  title = params[:title]
  @project = Project.new({:title => title, :id => nil})
  @project.save
  @projects = Project.all
  erb(:view_projects)
end

post('/projects/:id/edit') do
  name = params[:name]
  project_id = params[:id]
  @volunteer = Volunteer.new({:name => name, :id => nil, :project_id => project_id})
  @project = Project.find(params[:id])
  @volunteer.save()
  erb(:edit_project)
end



delete('/projects/:id/edit') do
  @project = Project.find(params[:id])
  @project.delete()
  @projects = Project.all
  erb(:view_projects)
end

delete('/volunteers/:id/edit') do
  @volunteer = Volunteer.find(params[:id])
  @volunteer.delete()
  @volunteers = Volunteer.all
  erb(:view_volunteers)
end

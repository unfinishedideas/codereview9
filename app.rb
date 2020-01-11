require('sinatra')
require('sinatra/reloader')
require('./lib/volunteer')
require('./lib/project')
require('pry')
require("pg")
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})
# ----------------GET--------------------- #
get('/') do
  @projects = Project.all
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

get('/projects/:id') do
  @project = Project.find(params[:id])
  erb(:view_project)
end

get('/volunteers/:id/edit') do
  @volunteer = Volunteer.find(params[:id])
  erb(:edit_volunteer)
end


# ----------------POST-------------------- #
post('/') do
  title = params[:title]
  @project = Project.new({:title => title, :id => nil})
  @project.save
  @projects = Project.all
  erb(:homepage)
end

post('/projects/:id/edit') do
  name = params[:name]
  project_id = params[:id]
  @volunteer = Volunteer.new({:name => name, :id => nil, :project_id => project_id})
  @project = Project.find(params[:id])
  @volunteer.save()
  erb(:edit_project)
end

# ---------------DELETE------------------- #
delete('/projects/:id/edit') do
  @project = Project.find(params[:id])
  @project.delete()
  @projects = Project.all
  erb(:homepage)
end

delete('/volunteers/:id/edit') do
  @volunteer = Volunteer.find(params[:id])
  @volunteer.delete()
  @volunteers = Volunteer.all
  @project = Project.find(@volunteer.project_id)
  erb(:view_project)
end

# ---------------PATCH-------------------- #
patch('/projects/:id/edit') do
  @project = Project.find(params[:id])
  title = params[:title]
  @project.update({:title => title})
  @projects = Project.all
  erb(:homepage)
end

patch('/volunteers/:id/edit') do
  @volunteer = Volunteer.find(params[:id])
  name = params[:name]
  @volunteer.update({:name => name})
  @volunteers = Volunteer.all
  @project = Project.find(@volunteer.project_id)
  erb(:view_project)
end

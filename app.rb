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

post('/projects') do
  title = params[:title]
  @project = Project.new({:title => title, :id => nil})
  @project.save
  @projects = Project.all
  erb(:view_projects)
end

get('/projects') do
  @projects = Project.all
  erb(:view_projects)
end

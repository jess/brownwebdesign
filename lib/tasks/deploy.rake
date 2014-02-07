desc 'Automate Deploy to Production'
task :deploy do
  app = "brownwebdesign"
  sh "git push origin master"
  sh "git push heroku master"
  # no database yet
  #Bundler.with_clean_env {sh "heroku pgbackups:capture --expire --app #{app}"}
  #Bundler.with_clean_env {sh "heroku run bundle exec rake db:migrate --app #{app}"}
  #Bundler.with_clean_env {sh "heroku restart --app #{app}"}
  sh "curl http://#{app}.herokuapp.com > /dev/null 2> /dev/null"
end

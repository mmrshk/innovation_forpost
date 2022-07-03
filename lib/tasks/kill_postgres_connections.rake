task :kill_postgres_connections => :environment do
  db_name = "#{Rails.configuration.database_configuration[Rails.env]['database']}"
  sh = "ps xa | grep postgres | grep #{db_name} | awk '{print $1}' | sudo xargs kill"
  puts `#{sh}`
end

task "db:drop" => :kill_postgres_connections
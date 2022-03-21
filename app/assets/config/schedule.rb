set :output, "log/cron.log"
every 1.minute do
#task will go here
rake Sample:email_sanitizer
p "inside scheduler"
end

set :output, "log/cron.log"
set :environment, 'development'
every 1.minute do
	rake "email:email_sanitizer_service"
	p "inside scheduler"
end

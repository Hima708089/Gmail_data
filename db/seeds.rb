# class Email
#   def email_sanitizer
#     obj = EmailSanitizer.create(in_time: intime, out_time:outtime , date: date, productive_hour:productive_hour, sent_by:sent_by, tasks:tasks)
#   end
# end

emails = Mail.find(:what => :first, :count => 10, :order => :asc)
	if emails.empty?
		p "No Emails"
	else
	emails.each do |email|
		#byebug
	   obj = EmailSanitizerService.new(email).execute!
	   EmployeeStatus.create(obj)
	end
end
#byebug
# obj = EmailSanitizer.new
# obj.save
#a = emails.first.subject
#productive_hour => a.split('Status ')[1].split(')')[1]
#only_hour=> a.split('Status ')[1].split('Productive')[1]
# project_name => spit('Project')[1].split('Completed')[0]
# project_name => spit('Project')[1].split('Reason')[0]
#Tasks => a.split('PM')[1].split('Reason')[0]
#y = emails.first.to_s
#email_id => y.split('Return-Path')[1].split('Rteceived')[0]














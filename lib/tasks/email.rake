namespace :email do
  p "inside rake"
  task email_sanitizer_service: :environment do
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
  end
end

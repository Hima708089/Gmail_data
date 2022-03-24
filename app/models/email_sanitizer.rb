class EmailSanitizer < ApplicationRecord
  before_save :set_attributes_value
  #validates :intime,:outtime, :tasks, :productive_hour,
            #:date, :sent_by, :project_name,
            #presence: true
  private

  	Mail.defaults do
      retriever_method :pop3, :address    => "pop.gmail.com",
                              :port       => 995,
                              :user_name  => 'st.himanshi@gmail.com',
                              :password   => '8574625441',
                              :enable_ssl => true
    end
    
    def set_attributes_value 
      email = Mail.find(:what => :first, :count => 10, :order => :asc)
      if email.empty?
        p "No Email Found"
      else
        #byebug
        body = email.first.body.to_s
        self.intime = body.split('In Time: ')[1].split('Out Time:')[0]# intime
        self.outtime = body.split('Out Time: ')[1].split('Today')[0]
        self.tasks = body.split('PM')[1].split('Project Name:')[0]
        self.project_name = body.split('Project')[1].split('Reason')[0]
        subject = email.first.subject
        self.productive_hour = subject.split('Status ')[1].split('Productive')[1]
        self.date = subject.split('Status ')[1].split(' Productive')[0]
        email_data = email.first.to_s
        self.sent_by = email_data.split('Return-Path')[1].split('Received')[0]
      end
    end
end



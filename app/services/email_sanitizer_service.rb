class EmailSanitizerService
  attr_accessor :email
  
  def initialize(email)
    @email = email       
  end

  def execute!
    #byebug
    {
      in_time: in_time,
      out_time: out_time,
      task1: task1,
      task2: task2,
      week_goals:week_goals,
      project_name: project_name,
      productive_hour: productive_hour,
      email_date: email_date,
      sent_by: sent_by,
      email_body: email_body,
      email_subject: email_subject
    }
  end
  
  private
   
    def in_time
      "#{email_body.split('In Time: ')[1].split('M')[0].strip}M"
    end

    def out_time
      "#{email_body.split('Out Time: ')[1].split('M')[0].strip}M"
    end

    def task1
      str1_markerstring = "Today, we completed the following tasks:"
      str2_markerstring = "Tomorrow, we plan on completing the following tasks:"
      email_body[/#{str1_markerstring}(.*?)#{str2_markerstring}/m, 1].gsub("\n", "").split("- ")
      #email_body.split('PM')[1].split('Project Name:')[0].strip 
    end

    def task2
      str2_markerstring = "Tomorrow, we plan on completing the following tasks:"
      str3_markerstring = "Goals for the week:"
      email_body[/#{str2_markerstring}(.*?)#{str3_markerstring}/m, 1].gsub("\n", "").split("- ")
      #email_body.split('PM')[1].split('Project Name:')[0].strip 
    end

    def week_goals
      str3_markerstring = "Goals for the week:"
      str4_markerstring = "Project :"
      email_body[/#{str3_markerstring}(.*?)#{str4_markerstring}/m, 1].gsub("\n", "").split("- ")
      #email_body.split("Goals for the week:")[1].split("Project")[0].gsub("\n","")
    end

    def project_name
      email_body.split('Project')[1].split('Reason')[0].strip
    end

    def productive_hour
      email_subject.split('Status ')[1].split('Productive')[1].strip
    end
    
    def email_date
      email_subject.split('Status ')[1].split(' Productive')[0].strip
    end
    
    def sent_by
      email_data.split('Return-Path')[1].split('Received')[0].strip
    end
    
    def email_body
      #byebug
      full_sanitizer = Rails::Html::FullSanitizer.new
      @email_body ||= full_sanitizer.sanitize(email.body.to_s)
    end

    def email_subject
      @email_subject = email.subject
    end

    def email_data
      @email_data = email.to_s
    end
end

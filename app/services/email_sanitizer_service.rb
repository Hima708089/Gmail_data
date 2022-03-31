class EmailSanitizerService
  attr_accessor :email
  PROJECT = []
  def initialize(email)
    @email = email       
  end

  def execute!
    byebug
    
    {
      intime: in_time,
      outtime: out_time,
      task1: task1,
      task2: task2,
      week_goals:week_goals,
      productive_hour: productive_hour,
      email_date: email_date,
      sent_by: sent_by,
      email_body: email_body,
      email_subject: email_subject
    }
  end
  
  private
   
    def in_time
      #"#{email_body.split('In Time: ')[1].split('M')[0].strip}M"
      "#{email_body.split('day')[1].split('*Out*')[0].strip.gsub("*"," ")}"
    end

    def out_time
      #"#{email_body.split('Out Time: ')[1].split('M')[0].strip}M"
      "#{email_body.split('AM')[1].split('*Productive')[0].strip.gsub("*"," ")}"

    end

    def task1
      project1 = email_body.split("PROJECT 1:")[1].split("PROJECT 2:")[0].gsub("\n"," ")
      project2 = email_body.split("PROJECT 2:")[1].split("Tomorrow, we plan on completing the following tasks:")[0].gsub("\n"," ")
      PROJECT.push(project1,project2)
      PROJECT.each do |p| 
      end
    end

    def task2
      str1_markerstring = "Tomorrow, we plan on completing the following tasks:"
      str2_markerstring = "Goals for the week:"
      email_body[/#{str1_markerstring}(.*?)#{str2_markerstring}/m, 1].gsub("\n", "").split("- ")
    end

    def week_goals
      str3_markerstring = "Goals for the week:"
      str4_markerstring = "Reason:"
      email_body[/#{str3_markerstring}(.*?)#{str4_markerstring}/m, 1].gsub("\n", "").split("- ")
      #email_body.split("Goals for the week:")[1].split("Project")[0].gsub("\n","")
    end

    def productive_hour
      "#{email_body.split('PM')[1].split('Today')[0].strip.gsub("*"," ").strip}"
    end
    
    def email_date
      email_subject.split('Status')[1].strip
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



#str = email.subject
#email_date => str.split('Status ')[1].strip
#email_body => email.body.to_s
#productive_hour => email_body.split('Productive Hour:')[1].split
#('Today, we have completed the following tasks:')[0]

#project1 => email_body.split("PROJECT 1:")[1].split("TASK 1:")[0].gsub("\n", " ")
#task1 => email_body.split("TASK 1:")[1].split("Description:")[0].gsub("\n", " ")
#Description => email_body.split("Description:")[1].split("STATUS:")[0].gsub("\n", " ")
#STATUS=> email_body.split("STATUS:")[1].split("SPENT TIME*:")[0].gsub("\n"," ")
#SPENT_TIME=> email_body.split("SPENT TIME*:")[1].split("TASK 2:")[0]
#TASK 2: => email_body.split("TASK 2:")[1].split("Description")[0]
#description=>email_body.split("Description")[1].split("STATUS")[0]



#Project1 - email_body.split("PROJECT 1:")[1].split("PROJECT 2:")[0].gsub("\n"," ")
#project2 - email_body.split("PROJECT 2:")[1].split("Tomorrow, we plan on completing the following tasks:")[0].gsub("\n"," ")
#PROJECT = []
#PROJECT.push(project1,project2)
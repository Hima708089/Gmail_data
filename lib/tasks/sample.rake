namespace :Sample do
  p "inside rake"
  task email_sanitizer: :environment do
    obj = EmailSanitizer.new
    obj.save
  end
end

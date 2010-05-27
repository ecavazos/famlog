ActionMailer::Base.smtp_settings = {
  :address              => 'smtp.gmail.com',
  :port                 => 587,
  :domain               => 'no.domain.com',
  :user_name            => 'actionmailer.smtp',
  :password             => 'F@mlog1122',
  :authentication       => 'plain',
  :enable_starttls_auto => true
}


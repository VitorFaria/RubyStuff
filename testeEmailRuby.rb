require 'net/smtp'

message = <<MESSAGE_END
From: Private Person <muad27@gmail.com>
To: A Test User <vitorfaria017@outlook.com>
Subject: SMTP e-mail test

This is a test e-mail message.
MESSAGE_END

Net::SMTP.start('localhost') do |smtp|
  smtp.send_message message, 'muad27@gmail.com', 
                             'vitorfaria017@outlook.com'
end

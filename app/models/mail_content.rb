class MailContent < ActiveRecord::Base

  varidates :text,    presence:  { message: 'は必須です' }

  varidates :subject, presence:  { message: 'は必須です' },
                      length:    {maximum: 400, message: 'は400文字以下にする必要があります' }
end

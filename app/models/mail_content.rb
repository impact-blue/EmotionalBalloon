class MailContent < ActiveRecord::Base

  validates :text,    presence:  { message: 'は必須です' }

  validates :subject, presence:  { message: 'は必須です' },
                      length:    {maximum: 400, message: 'は400文字以下にする必要があります' }
end

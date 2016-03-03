class Contact < ActiveRecord::Base
  validates :name,:content,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }

#お問い合わせの状態を日本語に対応
  def now_status
    if status == 0
      status =  '未'
    elsif status == 1
      status = '対応済み'
    end
  end

end

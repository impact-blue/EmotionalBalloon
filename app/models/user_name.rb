class UserName < ActiveRecord::Base
  belongs_to :user
  #belongs_to :order ,throgh: :user
  #validates :user_id, presence:  { message: 'は必須です' }
  validates :user_family_name, presence: { message: 'は必須です' },
                               exclusion: { in: %w({ }  . [ ] ) }

  validates :user_first_name, presence: { message: 'は必須です' },
                              exclusion: { in: %w({ }  . [ ] ) }

end

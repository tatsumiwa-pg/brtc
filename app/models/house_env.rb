class HouseEnv < ActiveHash::Base
  self.data = [
    { id:  1, name: '戸建て' },
    { id:  2, name: 'アパート' },
    { id:  3, name: 'マンション' },
    { id:  4, name: '寮' },
    { id:  5, name: 'ホテル等 宿泊施設' },
    { id:  6, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :profiles
end

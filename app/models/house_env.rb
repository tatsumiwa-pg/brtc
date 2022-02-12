class HouseEnv < ActiveHash::Base
  self.data = [
    { id:  1, name: '未選択' },
    { id:  2, name: '戸建て' },
    { id:  3, name: 'アパート' },
    { id:  4, name: 'マンション' },
    { id:  5, name: '寮' },
    { id:  6, name: 'ホテル等 宿泊施設' },
    { id:  7, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :profiles
end

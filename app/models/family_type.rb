class FamilyType < ActiveHash::Base
  self.data = [
    { id:  1, name: '未選択' },
    { id:  2, name: '1人暮らし' },
    { id:  3, name: '2人暮らし' },
    { id:  4, name: '3~4人' },
    { id:  5, name: '5人以上' },
    { id:  6, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :profiles
end

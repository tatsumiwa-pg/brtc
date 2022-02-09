class Age < ActiveHash::Base
  self.data = [
    { id:  1, name: '~17' },
    { id:  2, name: '~29' },
    { id:  3, name: '~39' },
    { id:  4, name: '~49' },
    { id:  5, name: '50~' }
  ]

  include ActiveHash::Associations
  has_many :profiles
end

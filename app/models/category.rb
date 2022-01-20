class Category < ActiveHash::Base
  self.data = [
    { id:  1, name: 'フード・おやつ'},
    { id:  2, name: '運動・おもちゃ'},
    { id:  3, name: '健康・病気・病院'},
    { id:  4, name: 'トレーニング・しつけ'},
    { id:  5, name: '住環境'},
    { id:  6, name: '家族'},
    { id:  7, name: '飼い猫'},
    { id:  8, name: 'ペットショップ'},
    { id:  9, name: 'その他お店'},
    { id: 10, name: '里親'},
    { id: 11, name: '保護猫'},
    { id: 12, name: '野良・地域猫'},
    { id: 13, name: '譲渡会'},
    { id: 14, name: '交流'},
    { id: 15, name: '旅行'},
    { id: 16, name: '本'},
    { id: 17, name: '家電'},
    { id: 18, name: '関連グッズ'},
    { id: 19, name: '動物倫理'},
    { id: 20, name: '学術・専門知識'},
    { id: 21, name: '資格・専門学校'},
    { id: 22, name: 'アレルギー'},
    { id: 23, name: '近隣トラブル'},
    { id: 24, name: 'Web'},
    { id: 25, name: '仕事・サービス'},
    { id: 26, name: 'その他'}
  ]

  include ActiveHash::Associations
  has_many :consultations
  
end
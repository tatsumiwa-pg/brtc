User.create(id: 1,	nickname: 'test',	email: 'test@test.com',	  password: '11111q')

4.times do |i|
  User.create(
    id:        i + 2,
    nickname:  "test#{i + 2}",
    email:     "test#{i + 2}@test.com",
    password:  '11111q'
  )
end

20.times do |i|
  Consultation.create(
    id:          i + 1,
    cons_title:  Faker::Lorem.characters(number: 1..50),
    category_id: Faker::Number.between(from: 1, to: 26),
    summary:     Faker::Lorem.characters(number: 1..150),
    situation:   Faker::Lorem.characters(number: 1..2000),
    problem:     Faker::Lorem.characters(number: 1..2000),
    user_id:     Faker::Number.between(from: 1, to: 3),
  )
end

100.times do |i|
  Answer.create(
    id:              i + 1,
    ans_title:       Faker::Lorem.characters(number: 1..40),
    ans_text:        Faker::Lorem.characters(number: 1..2000),
    user_id:         Faker::Number.between(from: 4, to: 5),
    consultation_id: Faker::Number.between(from: 1, to: 15),
  )
end

10.times do |i|
  Reconciliation.create(
    id:              i + 1,
    rec_text:        Faker::Lorem.characters(number: 1..40),
    consultation_id: i + 1
  )
end


100.times do |i|
  ConsComment.create{
    id:              i + 1,
    cons_c_text:     Faker::Lorem.characters(number: 1..40),
    consultation_id: Faker::Number.between(from: 1, to: 17),
  }
end

200.times do |i|
  AnsComment.create{
    id:              i + 1,
    ans_c_text:     Faker::Lorem.characters(number: 1..40),
    answer_id: Faker::Number.between(from: 1, to: 50),
  }
end

User.destroy_all
Question.destroy_all
Answer.destroy_all
Response.destroy_all
Vote.destroy_all

20.times do
	User.create!(email: Faker::Internet.email, password: "catcatcat")
end

50.times do
	Question.create!(user: User.all.sample, title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
end

200.times do
	Answer.create!(user: User.all.sample, body: Faker::Lorem.paragraph, question: Question.all.sample)
end

Question.all.each do |q|
	q.answers.sample.is_best = true unless q.answers.empty?
end

200.times do
	Response.create!(user: User.all.sample, body: Faker::Lorem.sentence, post: Question.all.sample)
end

500.times do
	Response.create!(user: User.all.sample, body: Faker::Lorem.sentence, post: Answer.all.sample)
end

2000.times do
	Vote.create!(value: 1, user: User.all.sample, votable: Question.all.sample)	
end

1000.times do
	Vote.create!(value: 1, user: User.all.sample, votable: Answer.all.sample)	
end

1000.times do
	Vote.create!(value: 1, user: User.all.sample, votable: Response.all.sample)	
end

200.times do
	Vote.create!(value: -1, user: User.all.sample, votable: Question.all.sample)	
end

100.times do
	Vote.create!(value: -1, user: User.all.sample, votable: Answer.all.sample)	
end

50.times do
	Vote.create!(value: -1, user: User.all.sample, votable: Response.all.sample)	
end
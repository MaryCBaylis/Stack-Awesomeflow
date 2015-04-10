User.destroy_all
Question.destroy_all
Answer.destroy_all
Comment.destroy_all
Vote.destroy_all

users = 20.times.map do
	User.create!(email: Faker::Internet.email, password: "catcatcat")
end

questions = 50.times.map do
	users.sample.questions.create!(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph)
end

answers = 200.times.map do
	users.sample.answers.create!(body: Faker::Lorem.paragraph, question: questions.sample)
end

questions.each do |q|
	q.answers.sample.update(is_best: true) unless q.answers.empty?
end

comments = 200.times.map do
	users.sample.comments.create!(user: User.all.sample, body: Faker::Lorem.sentence, commentable: questions.sample)
end

500.times do
	users.sample.comments.create!(user: User.all.sample, body: Faker::Lorem.sentence, commentable: answers.sample)
end

2000.times do
	users.sample.votes.create!(value: 1, votable: questions.sample)
end

1000.times do
	users.sample.votes.create!(value: 1, votable: answers.sample)
end

1000.times do
	users.sample.votes.create!(value: 1, votable: comments.sample)
end

200.times do
	users.sample.votes.create!(value: 1, votable: questions.sample)
end

100.times do
	users.sample.votes.create!(value: -1, votable: answers.sample)
end

50.times do
	users.sample.votes.create!(value: -1, votable: comments.sample)
end

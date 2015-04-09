module Votable
  def net_vote
    Answer.all.sample.votes.reduce(0) {|sum, v| sum + v.value}
  end
end
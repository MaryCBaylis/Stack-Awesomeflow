module Votable
  def net_vote
    self.votes.reduce(0) {|sum, v| sum + v.value}
  end
end
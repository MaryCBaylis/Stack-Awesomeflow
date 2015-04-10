module Votable
  def net_vote
    self.votes.reduce(0) {|sum, v| sum + v.value}
  end

  def vote_class(current_user)
    id = current_user.id if current_user
    if self.votes.find_by(user_id: (id || 0))
      self.votes.find_by(user_id: id).value == 1 ? "voted-up" : "voted-down"
    else
      "unvoted"
    end
  end
end
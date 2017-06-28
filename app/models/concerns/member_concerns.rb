module MemberConcerns

  def member_hash
    return nil if self.members.blank?
    return members.map do |member|
      [member.user.display_name, member.user.id]
    end
  end

end

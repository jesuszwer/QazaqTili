module UsersHelper
  def full_name(user)
    "#{user.name} #{user.last_name}"
  end
end

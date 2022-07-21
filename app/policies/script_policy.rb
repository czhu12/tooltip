class ScriptPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    return true if record.public?
    return true if owns?
    false
  end

  private
    def owns?
      record.user_id == user.id
    end
end

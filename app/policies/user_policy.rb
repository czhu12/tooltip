# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def update?
    has_access?
  end

  def has_access?
    user.id == record.id
  end
end
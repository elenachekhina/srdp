# Base class for application policies
class RatePolicy < ApplicationPolicy
  alias_rule :new?, to: :create?

  def create?
    record.rateable.rates.where(rater: user).empty?
  end
end

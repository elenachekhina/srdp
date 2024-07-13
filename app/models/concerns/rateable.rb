module Rateable
  extend ActiveSupport::Concern

  def rate
    Rate.where(rateable: self).average(:value).to_f
  end
end
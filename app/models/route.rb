class Route < ApplicationRecord
  has_many :stops

  validates :load_name, uniqueness: true

  def proccess_stops(params = {})
    raise StandardError.new('Cant verify params to build route stops') if params.blank?
  end
end

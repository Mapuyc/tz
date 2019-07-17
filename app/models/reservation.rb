class Reservation < ApplicationRecord
  belongs_to :table
  belongs_to :user
  validates :start_time, :end_time, :duration, presence: true
  validate :booking_time, :duration_time, :user_constraints, :table_constraints

  before_validation :add_end_time

  private

  def add_end_time
    self.end_time = start_time + duration.minutes
  end

  def duration_time
    errors.add(:duration, 'Must be a multiple of 30') unless duration % 30 == 0
  end

  def booking_time
    is_workin_day = table.restaurant.working_days.include?(start_time.wday)
    errors.add(:base, 'Invalid booking time') unless is_workin_day && is_start_time_valid && is_end_time_valid
  end

  def user_constraints
    return unless user.reservations
                      .where.not(table_id: table.id)
                      .where('start_time <= ? AND ? <= end_time', end_time, start_time)
                      .present?
    errors.add(:base, 'Invalid booking time')
  end

  def table_constraints
    return unless table.reservations
                       .where.not(user_id: user.id)
                       .where('start_time <= ? AND ? < end_time', end_time, start_time)
                       .present?
    errors.add(:base, 'Invalid booking time')
  end

  def is_start_time_valid?
    start_time.between?(table.restaurant.opens, table.restaurant.closes)
  end

  def is_end_time_valid
    end_time.between?(table.restaurant.opens, table.restaurant.closes)
  end

end

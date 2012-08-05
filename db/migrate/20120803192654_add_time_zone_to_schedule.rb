class AddTimeZoneToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :timezone, :string

  end
end

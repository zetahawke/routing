class CreateDelayedJobs < ActiveRecord::Migration[5.2]
  def self.up
    create_table :delayed_jobs, force: true do |table|
      table.integer  :priority, default: 0, null: false
      table.integer  :attempts, default: 0, null: false
      table.text     :handler,                 null: false
      table.text     :last_error
      table.datetime :run_at
      table.datetime :locked_at
      table.datetime :failed_at
      table.string   :locked_by
      table.string   :queue

      table.timestamps
    end

    add_index :delayed_jobs, [:priority, :run_at], name: 'delayed_jobs_priority'
    add_index :delayed_jobs, [:queue], :name => 'delayed_jobs_queue'
  end
end

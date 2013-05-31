class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.integer :status
      t.datetime :started_at
      t.datetime :finished_at
      t.references :job

      t.timestamps
    end
    add_index :builds, :job_id
  end
end

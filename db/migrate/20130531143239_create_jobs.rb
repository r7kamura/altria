class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.text :script
      t.text :config

      t.timestamps
    end
  end
end

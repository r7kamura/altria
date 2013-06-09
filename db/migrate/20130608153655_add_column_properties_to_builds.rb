class AddColumnPropertiesToBuilds < ActiveRecord::Migration
  def change
    add_column :builds, :properties, :text
  end
end

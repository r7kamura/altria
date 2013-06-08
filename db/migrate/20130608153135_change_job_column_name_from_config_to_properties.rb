class ChangeJobColumnNameFromConfigToProperties < ActiveRecord::Migration
  def up
    rename_column :jobs, :config, :properties
  end

  def down
    rename_column :jobs, :properties, :config
  end
end

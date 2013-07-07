class AddIncrementalIdToBuild < ActiveRecord::Migration
  def change
    add_column :builds, :incremental_id, :integer, default: 0
    Build.all.each do |build|
      count = build.job.builds.where("id <= ?", build.id).count
      build.update_attributes(incremental_id: count)
    end
  end
end

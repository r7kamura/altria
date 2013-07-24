class AddDefaultZeroToBuildsCountOfJobs < ActiveRecord::Migration
  def up
    change_column :jobs, :builds_count, :integer, default: 0
    Job.all.each do |job|
      job.update_attributes(builds_count: 0) if job.builds_count.nil?
    end
  end

  def down
    change_column :jobs, :builds_count, :integer, default: nil
  end
end

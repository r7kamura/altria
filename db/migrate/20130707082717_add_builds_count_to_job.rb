class AddBuildsCountToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :builds_count, :integer
    Job.all.each do |job|
      job.update_attributes(builds_count: job.builds.count)
    end
  end
end

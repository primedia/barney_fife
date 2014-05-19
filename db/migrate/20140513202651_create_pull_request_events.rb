class CreatePullRequestEvents < ActiveRecord::Migration
  def change
    create_table :pull_request_events do |t|
      t.string :owner
      t.string :repo
      t.string :sha
      t.string :pull_request_number

      t.timestamps
    end
  end
end

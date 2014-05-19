class AddRefToPullRequestEvent < ActiveRecord::Migration
  def change
    add_column :pull_request_events, :ref, :string
  end
end

class RemoveVotesFromVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :votes, :boolean
  end
end

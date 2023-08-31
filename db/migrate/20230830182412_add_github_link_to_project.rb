class AddGithubLinkToProject < ActiveRecord::Migration[7.0]
  def change
    add_column :projects, :github_link, :string
  end
end

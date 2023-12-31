ActiveAdmin.register Project do

  remove_filter :users
  remove_filter :checkpoints
  remove_filter :tasks
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :id_progetto, :info_leader, :dimensione, :descrizione, :stato
  #
  # or
  #
  # permit_params do
  #   permitted = [:id_progetto, :info_leader, :dimensione, :descrizione, :stato]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  actions :index, :edit, :update, :create, :destroy
  permit_params :id_progetto, :info_leader, :dimensione, :descrizione, :stato

end

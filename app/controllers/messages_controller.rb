class MessagesController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    chat = Chat.find(params[:chat_id])
    additional_params = { user_id: current_user.id, chat_id: chat.id }

    combined_params = message_params.merge(additional_params)

    Rails.logger.debug "combined_params: #{combined_params.inspect}"

    @message = Message.new(combined_params)
    respond_to do |format|
      if @message.save
        format.html { redirect_to project_show_my_project_path(project_id: @project.id) }
        format.json { render json: { data: "Some data fetched from server" } }
      else
        format.html { redirect_to project_show_my_project_path(project_id: @project.id) }
        format.json { render json: @message.errors, status: :unprocessable_entity }

      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end

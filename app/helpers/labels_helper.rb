module LabelsHelper
  def labels
    Label.where(user_id: current_user.id)
  end
end

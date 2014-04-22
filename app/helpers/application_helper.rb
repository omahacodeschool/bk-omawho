module ApplicationHelper
  
  def form_errors(form_model, model_name="form")
    render :partial => "layouts/form_errors", :locals => {:form_model => form_model, :model_name => model_name}
  end

end

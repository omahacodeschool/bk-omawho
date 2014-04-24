module ApplicationHelper
  
  def form_errors(form_model, model_name="form")
    render :partial => "layouts/form_errors", :locals => {:form_model => form_model, :model_name => model_name}
  end
  
  def event_date(time)
    time.strftime("%A, %B %e, %Y")
  end
  
  def event_time(time)
    time.strftime("%l:%M %P")
  end

end

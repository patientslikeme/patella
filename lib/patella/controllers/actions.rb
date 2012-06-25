module Patella::Actions
  def index
    patella_obj = Patella::Patella.from_key(params[:key])
    if patella_obj.loaded?
      render :partial => params[:partial], :locals => params.merge(:patella_obj => patella_obj)
    else
      render :status => 204, :nothing => true
    end
  end
end
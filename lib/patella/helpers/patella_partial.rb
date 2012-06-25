module Patella::PatellaPartial
  def patella_partial patella_obj, partial, params = {}
    if patella_obj.loaded?
      render :partial => partial, :locals => params.merge(:patella_obj => patella_obj)
    else
      key = patella_obj.cache_key
      params = params.merge(:partial => partial, :key => key)
      "<script>
         window.onload = function(){
         new Ajax.Updater('#patella-#{key}', '/patella',
                          { method: 'get',
                            parameters: #{params.to_json}});
         };
       </script>
       <div id='#patella-#{key}'></div>
       <div class='generic-spinner'>
         <img src='/images/indicator.gif', 'alt'='loading...', 'class'='loading-indicator dingbat-icon'/>
          Please wait. Loading data...
       </div>
       ".html_safe!
    end
  end
end
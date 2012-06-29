module Patella::PatellaPartial
  @@valid_templates = Set.new

  def patella_partial patella_obj, partial, params = {}
    if patella_obj.loaded?
      render :partial => partial, :locals => params.merge(:patella_obj => patella_obj)
    else
      key = patella_obj.cache_key
      params = params.merge(:partial => partial, :key => key)
      "<script>
         window.onload = function(){
          (function poll(){
             setTimeout(function(){
                $j.ajax({ url: '/patella',
                         dataType: 'html',
                         data: #{params.to_json},
                         success: function(data, textStatus, jqXHR){
                           console.log('statusCode '+jqXHR.statusCode());
                           if(jqXHR.statusCode() == 204){
                             poll();
                           }else{
                             $('patella-#{key}').innerHTML = data;
                           }
                         }
                       });
             }, 3000);
          })();
        }

       </script>
       <div id='patella-#{key}'>
         <div class='generic-spinner'>
           <img src='/images/indicator.gif', 'alt'='loading...', 'class'='loading-indicator dingbat-icon'/>
            Please wait. Loading data...
         </div>
       </div>
       ".html_safe!
    end
  end

  def javascript
  end
end
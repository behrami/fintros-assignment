document.addEventListener('DOMContentLoaded',function(){

  var stories = document.getElementById('storyList');

  window.addEventListener('scroll', function() {
   if($(window).scrollTop() + $(window).height() == $(document).height()) {
      console.log('fetching stories');
      alert('Pleace wait. We are fetching more stories.');

      var request = $.ajax({
                        		url: '/top_stories',
                        		method: 'GET',
                            dataType: 'html',
                        	})

      request.done(function(data){
       console.log('stories displayed');

       $(stories).append(data);
    	})

   }
 });

})

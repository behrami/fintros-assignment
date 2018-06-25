document.addEventListener('DOMContentLoaded',function(){

  var top_stories = document.getElementById("topStoryList");

  document.addEventListener('scroll', function() {
   if(top_stories && $(window).scrollTop() + $(window).height() == $(document).height()) {
      console.log('fetching top stories');

      var request = $.ajax({
                        		url: '/top_stories',
                        		method: 'GET',
                            dataType: 'html',
                        	})

      request.done(function(data){
       console.log('top stories displayed');
       $(top_stories).append(data);
    	})

   }

 });

})

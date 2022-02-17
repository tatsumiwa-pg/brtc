document.addEventListener('turbolinks:load', function() { 

  if (location.pathname.match(/\/answers/) && location.pathname.match(/\d$/)) {

    const reviewButton1 = document.getElementById('review_button1');
    const reviewButton2 = document.getElementById('review_button2');
    
    if (reviewButton1 !== null ) {
      reviewButton1.addEventListener('click', startReview);
    }
    if (reviewButton1 !== null ) {
      reviewButton2.addEventListener('click', startReview);
    }

    function startReview() {
      const floatMessageBox = document.getElementById("float_message_box");
      const displayStatus   = window.getComputedStyle(floatMessageBox);
    
      if (displayStatus.display === 'none') {
        floatMessageBox.setAttribute('style', 'display: flex');
      }
    
      const closeBtn = document.getElementById('close_btn');
      closeBtn.addEventListener('click', () => {
        floatMessageBox.removeAttribute('style', 'display: flex');
      });
      
    };
    
    const floatMessageBox = document.getElementById("float_message_box");
    const btns = document.getElementsByClassName('btns');
      for ( i = 0; i < btns.length ; i++ ) {
        btns[i].addEventListener('click', {floats: floatMessageBox, handleEvent: postReview});
      };

    function postReview() {
      const form = document.getElementById('review_form_wrapper');    
      this.floats.removeAttribute('style', 'display: flex');
      const formData = new FormData(form);
      const XHR = new XMLHttpRequest();
      XHR.open('POST', `${location.pathname}/reviews`, true);
      XHR.responseType = 'json';
      XHR.send(formData);
      XHR.onload = (endReview);
    };

    function endReview() {
      const reviewBox = document.getElementsByClassName('review-num')
      const newReview = this.response.review;
      const imgs = `<img src='/assets/nikukyu-1.png' alt='review points img' class="review-image">`
      
      for (i = 0; i < reviewBox.length; i++) {
        reviewBox[i].innerHTML = ''
        
        for (n = 0; n < newReview.point; n++) {
          reviewBox[i].insertAdjacentHTML('afterbegin', imgs)
        };
      };
      
    };

  };

});

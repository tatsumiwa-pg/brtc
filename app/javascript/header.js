document.addEventListener('turbolinks:load', function() { 

  const userImage = document.getElementById('user_image');
  const hiddenList = document.getElementById('hidden_list1');

  if (userImage !== null) {
  
    userImage.addEventListener('click', () => {
      if (hiddenList.getAttribute('style') == 'display: block;') {
        hiddenList.removeAttribute('style', 'display: block;')
      } else {
        hiddenList.setAttribute('style', 'display: block;')
      }
    });
  }

  const userMenuBtn = document.getElementById('user_menu_btn');
  const hiddenList2 = document.getElementById('hidden_list2');

  if (userMenuBtn !== null) {
  
    userMenuBtn.addEventListener('click', () => {
      if (hiddenList2.getAttribute('style') == 'display: block;') {
        hiddenList2.removeAttribute('style', 'display: block;')
      } else {
        hiddenList2.setAttribute('style', 'display: block;')
      }
    });
  }

});
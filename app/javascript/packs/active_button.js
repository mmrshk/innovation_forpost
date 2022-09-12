const items = document.querySelectorAll('.tag-search-item');

items.forEach(item => {
  item.addEventListener("click", function() {   
     item.classList.toggle("active");
  });  
});

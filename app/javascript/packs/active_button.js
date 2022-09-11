const items = document.querySelectorAll('.tag-search-item');

items.forEach(item => {
  item.addEventListener("click", function() {   
   items.forEach(a=>{
      a.classList.remove("active");
    });
     item.classList.add("active");
 
    
  });  
});

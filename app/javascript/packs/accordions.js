let accordions = document.querySelectorAll('.js-table-accordions');
accordions.forEach(accordion => {
  accordion.addEventListener('click', (event) => {
    table = accordion.parentElement.querySelectorAll('.js-table-accordions.active');
    if(table.length > 0 ) {
      table.forEach(item => item!= accordion && item.classList.toggle('active'));
    };
    accordion.classList.toggle('active');
    });
});

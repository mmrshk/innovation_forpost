let accordions = document.querySelectorAll('.js-table-accordions');
accordions.forEach(accordion => {
  accordion.addEventListener('click', (event) => {
    tables = accordion.parentElement.querySelectorAll('.js-table-accordions.active');
    if(tables.length > 0 ) {
      tables.forEach(item => item!= accordion && item.classList.toggle('active'));
    };
    accordion.classList.toggle('active');
    });
});

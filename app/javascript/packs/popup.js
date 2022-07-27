document.addEventListener('DOMContentLoaded', function() {
  let elems = document.querySelectorAll('.dropdown-trigger');
  options = {
    closeOnClick: false,
    constrainWidth: false,
  };
  let instances = M.Dropdown.init(elems, options);
});

// document.addEventListener('DOMContentLoaded', function() {
//   let elems = document.querySelectorAll('select');
//   // elems.addEventListener('click', (e) => {
//   //   e.preventDefault();
//   // })
//   let instances = M.FormSelect.init(elems, options);
// });

document.addEventListener('DOMContentLoaded', function() {
  var elems = document.querySelectorAll('.datepicker');
  var instances = M.Datepicker.init(elems, options);
});
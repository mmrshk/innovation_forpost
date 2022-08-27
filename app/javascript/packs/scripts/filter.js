document.addEventListener("turbo:load", ()=> {
  init();
})

document.addEventListener('DOMContentLoaded', function() {
  init()
});

function init() {
  let elems = document.querySelectorAll('.dropdown-trigger-1');
  options = {
    closeOnClick: false,
    constrainWidth: false,
  };
  let instances = M.Dropdown.init(elems, options);

  var datepickers = document.querySelectorAll('.datepicker');
  var dp = M.Datepicker.init(datepickers, {    
    closeOnClick: false,
    constrainWidth: true
  });
}

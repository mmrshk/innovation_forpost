const navtrigger = document.querySelector(".nav-trigger"),
mobilmenu = document.querySelector(".mobile-menu"),
container = document.querySelector(".header-container"),
top = document.querySelector(".header-top");

navtrigger.addEventListener("click", () => {
  navtrigger.classList.toggle("active");
  mobilmenu.classList.toggle("active");
  container.classList.toggle("active");
  container.style.boxShadow = "none";
  top.style.padding = "30px 0";
});

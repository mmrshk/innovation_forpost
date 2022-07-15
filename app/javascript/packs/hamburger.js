const NAV_TRIGER = document.querySelector(".nav-trigger"),
MOBILE_MENU = document.querySelector(".mobile-menu"),
HEADER_CONTAINER = document.querySelector(".header-container"),
HEADER_TOP = document.querySelector(".header-top");

NAV_TRIGER.addEventListener("click", () => {
  NAV_TRIGER.classList.toggle("active");
  MOBILE_MENU.classList.toggle("active");
  HEADER_CONTAINER.classList.toggle("active");
  HEADER_CONTAINER.classList.remove("scroll");
  HEADER_TOP.classList.toggle("active");
  HEADER_TOP.classList.remove("scroll");
});

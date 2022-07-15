window.addEventListener('scroll', () => {
  const HEADER_TOP = document.querySelector(".header-top"),
  HEADER_CONTAINER = document.querySelector(".header-container");
  let active = document.querySelector(".active");

  if (window.scrollY > 30 && !active) {
    HEADER_TOP.classList.add("scroll");
    HEADER_CONTAINER.classList.add("scroll");
  } else {
    HEADER_TOP.classList.remove("scroll");
    HEADER_CONTAINER.classList.remove("scroll");
  }
});

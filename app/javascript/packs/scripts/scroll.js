window.addEventListener('scroll', () => {
  const HEADER_TOP = document.querySelector(".header-top"),
  HEADER_CONTAINER = document.querySelector(".header-container");
  const active = document.querySelector(".active");
  const scrollArrow = document.querySelector('.welcome-video__scroll-icon');

  if (window.scrollY > 30 && !active) {
    HEADER_TOP.classList.add("scroll");
    HEADER_CONTAINER.classList.add("scroll");
  } else {
    HEADER_TOP.classList.remove("scroll");
    HEADER_CONTAINER.classList.remove("scroll");
  }

  if (window.screen.height <= 720) {
    if (window.scrollY > 124) {
      scrollArrow.style.display = 'none';
    } else {
      scrollArrow.style.display = 'block';
    }
  }
});

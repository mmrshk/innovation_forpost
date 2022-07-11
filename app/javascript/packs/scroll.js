window.addEventListener('scroll', () => {
  const top = document.querySelector(".header-top"),
  container = document.querySelector(".header-container"),
  active = document.querySelector(".active");

  if (window.scrollY > 30 && !active) {
    top.style.padding = "10px 0";
    container.style.boxShadow = "0 0 60px 0 #989898";
  } else {
    top.style.padding = "30px 0";
    container.style.boxShadow = "none";
  }
});

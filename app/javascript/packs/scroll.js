window.addEventListener('scroll', () => {
  const topbar = document.getElementsByClassName("top-bar")[0];
  const container = document.getElementsByClassName("container")[0];

  if (window.scrollY > 30) {
    topbar.style.padding = "0";
    container.style.boxShadow = "0 0 60px 0 #989898";
  } else {
    topbar.style.padding = "30px 0";
    container.style.boxShadow = "none";
  }
});

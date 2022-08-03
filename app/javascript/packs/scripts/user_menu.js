const USER_MENU = document.querySelector("#user-menu"),
USER_MENU_CONT = document.querySelector(".user-menu_content");

 if (!document.querySelector("#login")) {
  USER_MENU.addEventListener("click", () => {
    USER_MENU.classList.toggle("click");
    USER_MENU_CONT.classList.toggle("open");
  });
}

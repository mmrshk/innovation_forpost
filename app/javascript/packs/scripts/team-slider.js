const PREV  = document.querySelector('.prev'),
NEXT = document.querySelector('.next'),
TRACK = document.querySelector('.track');

let sliderWidth = document.querySelector('.slider-container').offsetWidth;

window.addEventListener('resize', () => {
  sliderWidth = document.querySelector('.slider-container').offsetWidth;
})

let index = 0;

NEXT.addEventListener('click', () => {
  index++;
  PREV.classList.add('show');
  TRACK.style.transform = `translateX(-${index * sliderWidth}px)`;
  if (TRACK.offsetWidth - (index * sliderWidth) < sliderWidth + 1) {
    NEXT.classList.add('hide');
  }
})

PREV.addEventListener('click', () => {
  index--;
  NEXT.classList.remove('hide');
  if (index === 0) {
    PREV.classList.remove('show');
  }
  TRACK.style.transform = `translateX(-${index * sliderWidth}px)`;
})

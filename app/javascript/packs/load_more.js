const currentItemsNews = 6;
const currentItemsDocs = 9;
const STEP_LOAD = 3

let loadMoreBtnNews = document.querySelector('.btn-news');
let newsContainer = document.querySelector('.news-container');

let loadMoreBtnDocs = document.querySelector('.btn-docs');
let docsContainer = document.querySelector('.docs-container');

function loadMoreButtonClick(btn, currentItemsLimit, step, container, className) {
  btn?.addEventListener('click', (e) => {
    let boxes = [...document.querySelectorAll(className)];
    let reshta = boxes.length-1 - currentItemsLimit
    if(reshta < step ) {
      step = reshta
    }
    for (let i = currentItemsLimit; i < currentItemsLimit + step; i++){
      if(currentItemsLimit - boxes.length < 3){
        boxes[i+1].style.display = 'flex';
        container.style.height = 'auto';
      }
    }

    currentItemsLimit += step;
  
    if(currentItemsLimit >= boxes.length){
      btn.style.display = 'none';
    }
  });
};

loadMoreButtonClick(loadMoreBtnNews, currentItemsNews, STEP_LOAD, newsContainer, '.news-block')
loadMoreButtonClick(loadMoreBtnDocs, currentItemsDocs, STEP_LOAD, docsContainer, '.docs-block')

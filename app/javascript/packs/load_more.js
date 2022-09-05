
var loadMoreBtnNews = document.querySelector('.btn-news');
var newsContainer = document.querySelector('.news-container');
var currentItemsNews = 6;

var loadMoreBtnDocs = document.querySelector('.btn-docs');
var docsContainer = document.querySelector('.docs-container');
var currentItemsDocs = 9;
const STEP_LOAD = 3

loadMoreBtnNews?.addEventListener('click', (e) => {
  let boxes_news = [...document.querySelectorAll('.news-block')];

  for (let i = currentItemsNews; i < currentItemsNews + 3; i++){
    boxes_news[i].style.display = 'flex';
      newsContainer.style.height = 'auto';
  }
  currentItemsNews += 3;

  if(currentItemsNews >= boxes_news.length){
      loadMoreBtnNews.style.display = 'none';
  }
});

// ***

loadMoreBtnDocs?.addEventListener('click', (e) => {
  let boxes_docs = [...document.querySelectorAll('.docs-block')];
  
  for (let i = currentItemsDocs; i < currentItemsDocs + 3; i++){
    boxes_docs[i].style.display = 'flex';
      docsContainer.style.height = 'auto';
  }
  currentItemsDocs += 3;

  if(currentItemsDocs >= boxes_docs.length){
    loadMoreBtnDocs.style.display = 'none';
  }
});

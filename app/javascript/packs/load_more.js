
// console.log(13 % 3) // 1 залишок від ділення
// console.log(parseInt((13/3))); // 4 цілочисельне ділення
// console.log(Math.ceil(13/3));  // 5 округлення до більшого

// let loadMoreBtn = document.querySelector('.button-load-more');
var loadMoreBtnNews = document.querySelector('.btn-news');
var newsContainer = document.querySelector('.news-container');
var currentItemsNews = 6;
var loadMoreBtnDocs = document.querySelector('.btn-docs');
var docsContainer = document.querySelector('.docs-container');
var currentItemsDocs = 9;
const STEP_LOAD = 3

// console.log(loadMoreBtnNews)


// loadMoreBtnNews.onclick = () =>{
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
  // console.log(boxes_docs.length)

  for (let i = 1; i < Math.ceil(boxes_docs.length/STEP_LOAD); i++){
    // console.log(Math.ceil(boxes_docs.length/STEP_LOAD)-2)
    // console.log(i)
    // function getStepLoad() {
    let getStepLoad = function() {
      console.log(i)
      let step = i === (Math.ceil(boxes_docs.length/STEP_LOAD)) ? boxes_docs.length % STEP_LOAD : STEP_LOAD
      return step
   };

   for (let j = currentItemsDocs; j < currentItemsDocs + 3; j++){
     boxes_docs[j].style.display = 'flex';
     docsContainer.style.height = 'auto';
    };
    // console.log(currentItemsDocs += getStepLoad())
    console.log(currentItemsDocs += getStepLoad())
    currentItemsDocs += getStepLoad();

    if(currentItemsDocs >= boxes_docs.length){
      loadMoreBtnDocs.style.display = 'none';
    }
  };
  
  // for (let i = currentItemsDocs; i < currentItemsDocs + 3; i++){
  //   boxes_docs[i].style.display = 'flex';
  //     docsContainer.style.height = 'auto';
  // }
  // currentItemsDocs += 3;

  // if(currentItemsDocs >= boxes_docs.length){
  //   loadMoreBtnDocs.style.display = 'none';
  // }
});

let selectData = document.querySelector(".pagy-items-selector-js input")
let currentUrl = window.location.href;

selectData?.addEventListener('input', (e) => {
  setTimeout(() => {
    let params = (new URL(currentUrl)).searchParams;
    let locale = params.get('locale')
    params.set('items', selectData.value)
    
    let url = window.location.origin + window.location.pathname + `?locale=${locale || 'uk'}&page=${params.get('page') || 1}&items=${params.get('items')}`;
    window.history.pushState({}, null, url);

    fetch(url).then(function (response) { return window.open(url, "_self"); })
  }, 2000);

})

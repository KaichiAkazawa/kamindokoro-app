if (location.pathname.match("stores/new")){
  document.addEventListener("DOMContentLoaded", () => {
    const inputElement = document.getElementById("store_word");

    inputElement.addEventListener("keyup", () => {
      const keyword = document.getElementById("store_word").value;
      const XHR = new XMLHttpRequest();

      XHR.open("GET", `tag_search/?keyword=${keyword}`, true);
      XHR.responseType = "json"
      XHR.send();
      XHR.onload = () => {
        const searchResult = document.getElementById("search-result")

        searchResult.innerHTML = "";  // 検索結果を削除

        if (XHR.response) {
          const tagName = XHR.response.keyword;

          tagName.forEach((tag) => {
            const childElement = document.createElement("div");
            const clickElement = document.getElementById(tag.id);

            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", tag.id);
            childElement.innerHTML = tag.word;

            searchResult.appendChild(childElement);

            clickElement.addEventListener("click", () => {
              document.getElementById("store_word").value = clickElement.textContent;
              clickElement.remove();
            });
          });
        };
      };
    });
  });
};
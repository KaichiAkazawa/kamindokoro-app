if (location.pathname.match("stores/new")){
  document.addEventListener("DOMContentLoaded", () => {
    const inputElement = document.getElementById("stores_tag_word");
    inputElement.addEventListener("keyup", () => {
      const keyword = document.getElementById("stores_tag_word").value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `search/?keyword=${keyword}`, true);
      XHR.responseType = "json"
      XHR.send();
      XHR.onload = () => {
        const searchResult = document.getElementById("search-result")
        searchResult.innerHTML = "";
        if (XHR.response) {
          const tagName = XHR.response.keyword;
          tagName.forEach((tag) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", tag.id);
            childElement.innerHTML = tag.word;
            searchResult.appendChild(childElement);
            const clickElement = document.getElementById(tag.id);
            clickElement.addEventListener("click", () => {
              document.getElementById("stores_tag_word").value = clickElement.textContent;
              clickElement.remove();
            });
          });
        };
      };
    });
  });
};
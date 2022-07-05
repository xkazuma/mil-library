<!-- * TODO: use modal of Bootstrap-->

<template>
  <div class="container library-search-world">
    <h2>Search books in the world</h2>
    <div id="search-in-world">
      <form class=" form-floating form-control-sm mb-1">
        <input v-model="inputIsbn"
               type="text"
               class="form-control"
               placeholder="13 numbers (e.g. 9780000000000)"
               aria-label="search a book by ISBN">
        <label for="text-isbn">
          ISBN-13
        </label>
      </form>
      <form class="form-floating form-control-sm mb-5">
        <input v-model="inputTitle"
               type="text"
               class="form-control"
               placeholder="by title (partial match)"
               aria-label="search books by title">
        <label for="text-title">
          Title of book
        </label>
      </form>
      <form class="form-floating form-control-sm mb-1 w-25 float-end">
        <label for="result-col" class="form-label">#columns of result</label>
        <input type="range" class="form-range" min="1" max="5" step="1" value="1">
      </form>
      <div id="search-world-result" class="container overflow-hidden">
        <div class="row row-cols-1">
          <div class="col gx-2 gy-2" v-for="book in results" :key="book.isbn">
            <literature-item :book=book></literature-item>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import LiteratureItem from "./LiteratureItem";
import axios from "axios";

export default {
  name: "library-search-world",
  components: {
    "literature-item": LiteratureItem
  },
  props: {},
  data() {
    return {
      results   : [],
      inputIsbn : "",
      inputTitle: "",
      url       : require('@/assets/noimage.png')
    };
  },
  watch: {
    inputIsbn(inputIsbn) {
      const baseurl = "https://api.openbd.jp/v1/get";
      if (inputIsbn.length === 13) {
        const requestUrl = baseurl + "?isbn=" + inputIsbn;
        axios.get(requestUrl)
            .then(response => {
              const data = response.data[0]
              const book = {};
              book.isbn = data.summary.isbn;
              book.title = data.summary.title;
              book.author = data.summary.author;
              book.image = data.summary.cover;
              book.desc = data.onix.CollateralDetail.TextContent[0].Text;
              this.results.push(book);
            })
            .catch(error => {
              console.log(error);
              this.results = [];
            });
      } else {
        this.results = [];
      }
    },
    inputTitle(inputTitle) {
      const baseurl = "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404";
      if (inputTitle.length >= 3) {
        const requestUrl = baseurl + "?format=json&title=" + inputTitle + "&applicationId=1064472035819181340";
        axios.get(requestUrl)
            .then(response => {
              this.results = [];
              console.log(response.data.Items);
              for (const item of response.data.Items) {
                const book = {};
                book.isbn = item.Item.isbn;
                book.title = item.Item.title;
                book.author = item.Item.author;
                book.image = item.Item.mediumImageUrl;
                book.desc = item.Item.itemCaption;
                this.results.push(book);
              }
            })
            .catch(error => {
              console.log(error);
              this.results = [];
            });
      } else {
        this.results = [];
      }
    },
    results(results) {
      return results;
    }

  }
}
</script>

<style scoped>

</style>
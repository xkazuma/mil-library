<template>
  <div class="container library-search-lab">
    <h2>Search books in MIL</h2>
    <div id="search-in-lab">
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
import LiteratureItem from "@/components/LiteratureItem";
import axios from "axios";
import { ref } from 'vue';

export default {
  name: "library-search-lab",
  components: {
    "literature-item": LiteratureItem
  },
  props: {},

  setup() {

    const all        = ref([]);
    const results    = ref([]);
    const inputIsbn  = ref("");
    const inputTitle = ref("");
    const url        = require('@/assets/noimage.png')

    axios.get('/literatures/list')
        .then(response => {
          for (const item of response.data) {
            const book = {};
            book.isbn   = item.isbn;
            book.title  = item.title;
            book.author = item.author;
            book.image  = item.image;
            book.desc   = item.description;
            all.value.push(book);
          }
          resetResult();
        })
        .catch(error => {
          console.log(error);
        });

    const resetResult = () => {

      results.value = JSON.parse(JSON.stringify(all.value));

    }

    resetResult();

    return {
      all,
      results,
      inputIsbn,
      inputTitle,
      url,
      resetResult,
    };

  },

  watch: {
    inputIsbn(inputIsbn) {
      if (inputIsbn.length === 13) {
        axios.get('/literatures/isbn/' + inputIsbn)
            .then(response => {

              this.results.splice(0);
              for (const item of response.data) {
                const book = {};
                book.isbn   = item.isbn;
                book.title  = item.title;
                book.author = item.author;
                book.image  = item.image;
                book.desc   = item.description;
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

    inputTitle(inputTitle) {

      if(inputTitle.length === 0) this.resetResult();

      this.results.splice(0);

      for(const item of this.all) {

        if(item.title.indexOf(inputTitle) !== -1) {

          const book = {};
          book.isbn   = item.isbn;
          book.title  = item.title;
          book.author = item.author;
          book.image  = item.image;
          book.desc   = item.description;
          this.results.push(book);

        }
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
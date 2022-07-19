<!-- * TODO: use modal of Bootstrap-->

<template>
  <div class="offcanvas offcanvas-start"
       :class="getOffcanvasShow"
       :style="getOffcanvasVisility"
       data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvas-books" aria-labelledby="offcanvasLabel">
    <div class="offcanvas-header">
      <h4 class="offcanvas-title" id="offcanvasLabel">入刊保留</h4>
      <button
          type="button"
          class="btn-close text-reset"
          data-bs-target="#offcanvas-books"
          data-bs-toggle="offcanvas"
          data-bs-dismiss="offcanvas"
          aria-label="Close"
          @click="closeOffCanvas"/>
    </div>
    <div class="offcanvas-body">
      <div class="form">
        <div class="d-grid gap-2">
          <div class="btn-group mb-3" role="group" aria-label="add or cancel">
            <button type="submit" class="btn btn-success" @click="insertIntoDB()">入刊確定</button>
            <button type="button" class="btn btn-warning" @click="resetBasket()">全消去</button>
          </div>
        </div>
        <p>以下の書籍が蔵書登録の候補として保持しています。</p>
        <div id="in-a-basket" class="container overflow-hidden">
          <div class="row row-cols-1" v-for="book in basket" :key="book.isbn">
            <div class="container in-offcanvas">
              <div class="row row-cols-2">
                <div class="col col-1">
                  <button
                      type="button"
                      class="btn-close text-reset"
                      aria-label="remove"
                      @click="registerBookBasketToggle(book)"/>
                </div>
                <div class="col col-11">
                  <literature-item
                      :book=book
                      :inBasket=true
                      :compInBasket=true />
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

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
        <div class="container">
          <div class="row row-cols-2" v-for="book in results" :key="book.isbn">
            <div class="col col-1">
              <div class="d-grid gap-2">
                <a class="btn"
                   :class="buttonStatus[book.isbn].btnClass"
                   @click="registerBookBasketToggle(book);openOffCanvas()">
                  {{ buttonStatus[book.isbn].btnLabel }}
                </a>
              </div>
            </div>
            <div class="col col-11">
              <literature-item
                  :book=book
                  :inBasket=false
                  :compInBasket=false />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import LiteratureItem from "./LiteratureItem";
import axios from "axios";
import { ref, toRefs } from 'vue';

export default {
  name: "library-search-world",
  components: {
    "literature-item": LiteratureItem
  },

  props: {},

  setup() {

    const buttonLbls = {
      REMOVE: '除外',
      ADD:    '追加',
      EXIST:  '蔵書',
    };
    const buttonClass = {
      PRIMARY  : 'btn-primary',
      DANGER   : 'btn-danger',
      ODANGER  : 'btn-outline-danger',
      DISABLED : 'btn-outline-dark disabled',
    };

    const buttonStatus      = ref({})

    const results           = ref({});
    const basket            = ref({});

    const inputIsbn         = ref("");
    const inputTitle        = ref("");

    const url               = require('@/assets/noimage.png');

    const offcanvasVisility = ref("visibility: visible");
    const offcanvasShow     = ref("show");

    const addBookIntoBasket = (book) => {

      if (! book) return;

      const rbook = toRefs(book);
      basket.value[rbook.isbn.value]                = rbook;
      buttonStatus.value[rbook.isbn.value].btnLabel = buttonLbls.REMOVE;
      buttonStatus.value[rbook.isbn.value].btnClass = buttonClass.DANGER;

    };

    const removeBookInBasket = (book) => {

      if (! book) return;

      const rbook = toRefs(book);

      delete basket.value[rbook.isbn.value];
      buttonStatus.value[rbook.isbn.value].btnLabel = buttonLbls.ADD;
      buttonStatus.value[rbook.isbn.value].btnClass = buttonClass.PRIMARY;

    };

    const registerBookBasketToggle = (book) => {

      if (book.isbn in basket.value) {

        removeBookInBasket(book);

      } else {

        addBookIntoBasket(book);

      }
    };

    const openOffCanvas = () => {

      offcanvasVisility.value = "visibility: visible";
      offcanvasShow.value     = "show";

    };

    const closeOffCanvas = () => {

      offcanvasVisility.value = "visibility: hidden";
      offcanvasShow.value     = "";

    };

    const resetBasket = () => {

      for (const isbn in basket.value) {

        registerBookBasketToggle(basket.value[isbn]);

      }
    };

    const insertIntoDB = () => {

      for (const isbn in basket.value) {

        axios.post('/literatures/literature/create', basket.value[isbn])
            .then(function() {
              buttonStatus.value[isbn].btnLabel = buttonLbls.EXIST;
              buttonStatus.value[isbn].btnClass = buttonClass.DISABLED;
            })
            .catch(error => {
              console.log(error);
            });

      }
    };


    return {

      buttonLbls,
      buttonClass,
      buttonStatus,
      results,
      basket,
      inputIsbn,
      inputTitle,
      url,
      offcanvasVisility,
      offcanvasShow,
      registerBookBasketToggle,
      openOffCanvas,
      closeOffCanvas,
      resetBasket,
      insertIntoDB,

    };
  },

  watch: {

    inputIsbn(inputIsbn) {
      const baseurl = process.env.VUE_APP_OPENBD_API_BASE;
      if (inputIsbn.length === 13) {
        let exists;
        axios.get('/literatures/isbn/' + inputIsbn)
            .then(response => {
               exists = response.data[0] != null;
            })
            .catch(error => {
              console.log(error);
            });
        const requestUrl = baseurl + "?isbn=" + inputIsbn;
        axios.get(requestUrl)
            .then(response => {
              const data = response.data[0]
              const book = {};
              book.isbn        = data.summary.isbn;
              book.title       = data.summary.title;
              book.author      = data.summary.author;
              book.image       = data.summary.cover;
              book.description = data.onix.CollateralDetail.TextContent[0].Text;
              book.exists      = exists;
              this.results.value[book.isbn] = book;

              this.buttonStatus[book.isbn] = {
                btnClass : this.buttonClass.PRIMARY,
                btnLabel : this.buttonLbls.ADD
              }
            })
            .catch(error => {

              console.log(error);
              this.results = ref({});

            });
      } else {

        this.results = ref({});

      }
    },

    inputTitle(inputTitle) {

      const baseurl = process.env.VUE_APP_RAKUTEN_API_BASE;
      if (inputTitle.length >= 3) {

        this.results = ref({});
        const requestUrl = baseurl + "?format=json&title=" + inputTitle + "&applicationId=" + process.env.VUE_APP_RAKUTEN_APP_APIKEY
        axios.get(requestUrl)
            .then(response => {
              for (const item of response.data.Items) {
                const book = {};
                book.isbn        = item.Item.isbn;
                book.title       = item.Item.title;
                book.author      = item.Item.author;
                book.image       = item.Item.mediumImageUrl;
                book.description = item.Item.itemCaption;
                axios.get('/literatures/isbn/' + item.Item.isbn)
                    .then(responseISBN => {
                      book.exists = responseISBN.data[0] !=  null;
                      this.results[book.isbn] = book;
                      this.buttonStatus[book.isbn] = {
                        btnClass : this.buttonClass.PRIMARY,
                        btnLabel : this.buttonLbls.ADD
                      }
                    })
                    .catch(error => {
                      book.exists = false;
                      this.results[book.isbn] = book;
                      this.buttonStatus[book.isbn] = {
                        btnClass : this.buttonClass.PRIMARY,
                        btnLabel : this.buttonLbls.ADD
                      }
                      console.log(error);
                    });
              }
            })
            .catch(error => {
              console.log(error);
            });

      } else {

        this.results = ref({});

      }
    },

    results() {},

    basket(basket) {

      return basket;

    },

    offcanvasVisility(offcanvasVisility) {

      return offcanvasVisility;

    },

    offcanvasShow(offcanvasShow) {

      return offcanvasShow;

    },
  },

  computed : {

    getOffcanvasVisility : function() {

      return this.offcanvasVisility;

    },

    getOffcanvasShow : function() {

      return this.offcanvasShow;

    },
  },

  methods : { }
}
</script>

<style scoped>
</style>

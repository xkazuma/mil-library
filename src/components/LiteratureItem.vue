<template>
  <div class="card bg-light h-100 literature-item">
    <div class="row g-0">
      <div class="col-md-4">
        <img class="card-img-top img-thumbnail" v-bind:alt="[book.title]" v-bind:src=[book.image]>
      </div>

      <div class="col-md-8">
        <div v-if="compInBasket === false"
             class="card-body" >
          <h4 class="card-title">{{book.title}}</h4>

          <h5 class="card-text">{{book.author}}</h5>
          <p class="card-text">{{book.desc}}</p>
        </div>
        <div v-else
             class="card-body" >
          <h6 class="card-title">{{book.title}}</h6>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

export default {

  name: "literature-item",
  props: {
    book: {
      author      : String,
      title       : String,
      image       : String,
      description : String,
      isbn        : String,
      exists      : Boolean,
    },
    inBasket     : Boolean,
    compInBasket : Boolean,
  },

  setup() { },

  watch : {

    buttonText(buttonText) {

      return buttonText;

    },

    buttonClass(buttonClass) {

      return buttonClass;

    }
  },

  computed: { },

  methods: { },

}
</script>

<style scoped>
.card-title {
  text-overflow: ellipsis " [..]";
}
p.card-text {
  overflow-wrap: break-word;
}
</style>

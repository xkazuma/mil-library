<template>
  <div class="card h-100 literature-item">
    <div class="row g-0">
      <div class="col-md-4">
        <img class="card-img-top img-thumbnail" v-bind:alt="[book.title]" v-bind:src=[book.image]>
      </div>
      <div class="col-md-8">
        <div class="card-body">
          <h4 class="card-title">{{book.title}}</h4>
          <h5 class="card-text">{{book.author}}</h5>
          <p class="card-text">{{book.desc}}</p>
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
      author: String,
      title: String,
      image: String,
      desc: String,
      isbn: String,
    }
  },
  data() {},
  computed: {}
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
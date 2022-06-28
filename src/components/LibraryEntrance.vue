<template>
  <div class="library-entrance">
    <h1>MIL Library</h1>
    <p>
      Welcome to MIL Library!!!
    </p>

    <h2>New literatures...</h2>
    <ul id = "new">
    </ul>
    <h2>Favorite literatures...</h2>
    <ul id = "fav">
    </ul>
    <h2>Others...</h2>
    <ul id = "other">
    </ul>
  </div>

</template>

<script>

export default {
  name: "LibraryEntrance.vue",
  components: {
    //LiteratureItem
  },
  props: {
  }
}
</script>

<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
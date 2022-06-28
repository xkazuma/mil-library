<template>
  <div class = "literature-item">
    <img alt="{{title}}" src="{{URL}}">
    <h1 class = "literature-title">{{title}}</h1>
    <p class = "literature-desc">{{desc}}</p>
  </div>
</template>

<script>
export default {
  name: "LiteratureItem",
  props: {
    title: String,
    image: URL,
    desc: String
  }
}
</script>

<style scoped>

</style>
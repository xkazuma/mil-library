<template>
  <div class="container">
    <img alt="MIL logo" src="./assets/millogo-h.png">
  </div>
  <library-entrance />
</template>

<script>
import LibraryEntrance from './components/LibraryEntrance'

export default {
  name: 'App',
  components: {
    LibraryEntrance
  }
}
</script>

<style>
img {
  width : 50%;
}
</style>
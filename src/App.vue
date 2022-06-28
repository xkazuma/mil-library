<template>
  <img alt="MIL logo" src="./assets/millogo-h.png">
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
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>

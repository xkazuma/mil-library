<template>
  <div class="library-entrance">
    <h1>MIL Library</h1>
    <p>
      Welcome to MIL Library!!!
    </p>

    <nav class = "nav justify-content-center">
      <a class = "nav-link" v-for="tab in tabs"
          v-bind:key="tab"
          v-on:click="activeTab = tab">
        {{ tab }}
      </a>
    </nav>
    <component class="tabContents" v-bind:is="selectTab"></component>
  </div>
</template>

<script>
import LibrarySearchTop   from './LibrarySearchTop.vue'
import LibrarySearchLab   from './LibrarySearchLab.vue'
import LibrarySearchWorld from './LibrarySearchWorld.vue'

export default {
  name: "library-entrance",
  components: {
    'library-search-top'  : LibrarySearchTop,
    'library-search-lab'  : LibrarySearchLab,
    'library-search-world': LibrarySearchWorld
  },
  props: {
  },
  data() {
    return {
      activeTab: "Top",
      tabs     : ["Top", "Lab", "World"]
    }
  },
  computed: {
    selectTab: function () {
      return "library-search-" + this.activeTab.toLowerCase();
    }
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
  color: #39b17b;
}

/* tab */
</style>
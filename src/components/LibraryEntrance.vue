<template>
  <div class="container library-entrance">
    <nav class = "nav justify-content-center">

      <a class = "nav-link" v-for="tab in tabs"
         v-bind:key="tab.name"
         v-on:click="activeTab = tab.name">
        {{ tab.label }}
      </a>
    </nav>
    <keep-alive>
    <component class="tabContents" v-bind:is="selectTab"></component>
    </keep-alive>
  </div>
</template>

<script>
import LibrarySearchTop   from './LibrarySearchTop.vue'
import LibrarySearchLab   from './LibrarySearchLab.vue'
import LibrarySearchWorld from './LibrarySearchWorld.vue'
import { ref }            from 'vue';

export default {

  name: "library-entrance",
  components: {
    'library-search-top'  : LibrarySearchTop,
    'library-search-lab'  : LibrarySearchLab,
    'library-search-world': LibrarySearchWorld
  },

  props: { },

  setup() {

    const title     = process.env.VUE_APP_TITLE;
    const activeTab = ref("top");
    const tabs      = [
      { name  : "top",   label : "トップページ" },
      { name  : "lab",   label : "研究室から探す" },
      { name  : "world", label : "APIで世界から探す" },
    ];

    return {

      title,
      activeTab,
      tabs,

    }
  },
  computed: {

    selectTab: function () {

      return "library-search-" + this.activeTab;

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

<template>
  <div>
    <ul class="test-list" v-for="user in notesList" :key="user.id">
      <li class="test-list--item">
        <strong>{{ user.title}}</strong> <br>
        {{ user.notes }} <br>
        <p>Created on : {{ user.created_at}}</p>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from "axios";

export default {
  data() {
    return {
      notesList: []
    };
  },
  mounted() {
    axios.get("http://localhost:5000/v1/notes/")
      .then(res => {
        this.notesList = res.data.data;
        console.log(this.notesList)
      })
      .catch(error => {
        console.log(error)
         // Manage errors if found any
      })
  }
};
</script>

<style>
ul {
  margin: 0 auto;
  width: 300px;
  text-align: left;  
}

li {
  display: block;
  margin-bottom: 10px;
  border: 1px solid #ccc;
  padding: 15px;
}
</style>
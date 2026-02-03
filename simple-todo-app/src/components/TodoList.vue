<template>
  <div class="container">
    <div class="row">
      <div class="col-12 py-5">
        <h1>{{ listName }}</h1>
      </div>
    </div>
    <div class="row mb-3">
      <create-todo @on-new-todo="addTodo($event)" />
    </div>
    <div class="row">
      <div class="col-12 col-sm-10 col-lg-8">
        <ul class="list-group">
          <todo
            v-for="(todo, index) in todos"
            :key="index"
            :description="todo.description"
            :completed="todo.completed"
            @on-toggle="toggleTodo(todo)"
            @on-delete="deleteTodo(todo)"
            @on-edit="editTodo(todo, $event)"
          />
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
import Todo from "./Todo.vue";
import CreateTodo from "./CreateTodo.vue";

export default {
  props: {
    listName: String
  },
  data() {
    return {
      todos: [
        { id: 0, description: "Test this fancy application", completed: false },
        {
          id: 1, 
          description: "Learn Docker (because it is awesome)",
          completed: false
        },
        { id: 2, description: "Pass this assignment", completed: false }
      ]
    };
  },
  methods: {
    addTodo(newTodo) {
      const newId = Math.max(...this.todos.map(t => t['id'])) + 1
      this.todos.push({ id: newId, description: newTodo, completed: false })
    },
    toggleTodo(todo) {
      todo.completed = !todo.completed
    },
    deleteTodo(deletedTodo) {
      this.todos = this.todos.filter(todo => todo !== deletedTodo)
    },
    editTodo(todo, newTodoDescription) {
      todo.description = newTodoDescription
    }
  },
  components: { Todo, CreateTodo }
};
</script>

<style scoped lang="scss"></style>

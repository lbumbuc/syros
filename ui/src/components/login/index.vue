<template>
  <div class="login">
    <div class="login-container">
      <h1>Syros</h1>
      <div class="alert alert-danger" v-if="error">
        <p>{{ error }}</p>
      </div>
      <form @submit.prevent="login(user)">
        <div class="form-group form-group-lg">
          <div class="input-group">
            <div class="input-group-addon">
              <i class="fa fa-envelope fa-fw"></i>
            </div>
            <input
              v-model="user.name"
              type="input"
              placeholder="Username"
              class="form-control"
            >
          </div>
        </div>
        <div class="form-group form-group-lg">
          <div class="input-group">
            <div class="input-group-addon">
              <i class="fa fa-lock fa-fw"></i>
            </div>
            <input
              v-model="user.password"
              type="password"
              placeholder="Password"
              class="form-control"
            >
          </div>
        </div>
        <div class="form-group">
          <button class="btn btn-default btn-lg">
            Login
          </button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
  import Vue from 'vue'
  import auth from 'components/auth.vue'

  export default {
    name: 'login',
    data () {
      return {
        error: null,
        user: {
          name: null,
          password: null
        }
      }
    },
    methods: {
      login (user) {
        if (!user.name || !user.password) {
          this.error = 'Invalid Username or Password'
        } else {
          this.$Progress.start()
          Vue.$http.post('/auth/login', user)
            .then((response) => {
              if (response != null) {
                this.$Progress.finish()
                auth.login(response.data)
                this.$router.push(this.$route.params.redirect)
              } else {
                this.$Progress.fail()
              }
            })
            .catch((error) => {
              if (error.message === 'Network Error') {
                this.error = 'Could not connect to the server'
              } else {
                this.error = error.response.data
              }
              this.$Progress.fail()
            })
        }
      }
    }
  }

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  h1,
  h2 {
    font-weight: normal;
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

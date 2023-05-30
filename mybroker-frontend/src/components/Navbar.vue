<template>
<nav class="navbar navbar-light navbar-expand-md fixed-top navbar-shrink py-3" id="mainNav">
    <div class="container"><router-link class="navbar-brand d-flex align-items-center" to="/">My Insurance Broker
</router-link><button data-bs-toggle="collapse" class="navbar-toggler" data-bs-target="#navcol-1"><span class="visually-hidden">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navcol-1">
            <ul class="navbar-nav mx-auto">
                <li class="nav-item"><div class="nav-link active"><router-link to="/">Home</router-link></div></li>
                <li class="nav-item"><div class="nav-link"><router-link to="/blog">Blog</router-link></div></li>
                <li class="nav-item"><div class="nav-link"><router-link to="/contact">Contact us</router-link></div></li>
                <li class="nav-item"><div class="nav-link"><router-link to="/get-quote">Get estimation</router-link></div></li>
            </ul><router-link class="btn btn-primary shadow" to="/sign-up">Sign up</router-link>
        </div>
    </div>
</nav>
<router-view></router-view>
</template>
<script>
  (function() {
  "use strict"; // Start of use strict

  var mainNav = document.querySelector('#mainNav');

  if (mainNav) {

    // Collapse Navbar
    var collapseNavbar = function() {

      var scrollTop = (window.pageYOffset !== undefined) ? window.pageYOffset : (document.documentElement || document.body.parentNode || document.body).scrollTop;

      if (scrollTop > 100) {
        mainNav.classList.add("navbar-shrink");
      } else {
        mainNav.classList.remove("navbar-shrink");
      }
    };
    // Collapse now if page is not at top
    collapseNavbar();
    // Collapse the navbar when page is scrolled
    document.addEventListener("scroll", collapseNavbar);
  }

})(); // End of use strict
export default {
  name: 'NavbarComponent'
}
</script>

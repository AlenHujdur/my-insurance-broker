<template>
      <section class="py-5 mt-5">
        <div class="container py-5">
            <div class="row">
                <div class="col-md-8 col-xl-6 text-center mx-auto">
                    <h2 class="display-6 fw-bold mb-4">Got any <span class="underline">questions</span>?</h2>
                    <p class="text-muted">Our team of experts is always here to help. Send us a message and we'll get back to you shortly.</p>
                </div>
            </div>
            <div class="row d-flex justify-content-center">
                <div class="col-md-6">
                    <div>
                        <form class="p-3 p-xl-4" @submit.prevent="subscribe">
                            <div class="mb-3"><input class="shadow form-control" type="text" id="name-1" name="name" placeholder="Name" v-model="name"></div>
                            <div class="mb-3"><input class="shadow form-control" type="email" id="email-1" name="email" placeholder="Email" v-model="email"></div>
                            <div class="mb-3"><input class="shadow form-control" type="tel" id="phone-1" name="phone" placeholder="Phone" v-model="phone"></div>
                            <div class="mb-3"><textarea class="shadow form-control" id="message-1" name="message" rows="6" placeholder="Message" v-model="message"></textarea></div>
                            <div><button class="btn btn-primary shadow d-block w-100" type="submit">Send </button></div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <section class="py-4 py-xl-5 mb-5">
        <div class="container">
            <div class="row mb-2">
                <div class="col-md-8 col-xl-6 text-center mx-auto">
                    <h2 class="display-6 fw-bold mb-5"><span class="pb-3 underline">FAQ<br></span></h2>
                    <p class="text-muted mb-5">See some of the most asked questions here below.&nbsp;<span style="color: rgb(45, 45, 45);">Please note that the above FAQ is a general example and the specific questions and answers may vary based on the insurance provider and their policies.</span></p>
                </div>
            </div>
            <div class="row mb-2">
                <div class="col-md-8 mx-auto">
                    <div class="accordion text-muted" role="tablist" id="accordion-1">
                        <div class="accordion-item">
                            <h2 class="accordion-header" role="tab"><button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#accordion-1 .item-1" aria-expanded="false" aria-controls="accordion-1 .item-1">How do I file an insurance claim?</button></h2>
                            <div class="accordion-collapse collapse item-1" role="tabpanel" data-bs-parent="#accordion-1">
                                <div class="accordion-body">
                                    <p>In the event of an incident or loss covered by your insurance policy, simply contact our claims department. Our representatives will guide you through the claims process, assisting you in documenting the details and supporting evidence. We aim to make the claims process as smooth and efficient as possible.</p>
                                    <p class="mb-0"></p>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header" role="tab"><button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#accordion-1 .item-2" aria-expanded="false" aria-controls="accordion-1 .item-2">Can I make changes to my insurance policy?</button></h2>
                            <div class="accordion-collapse collapse item-2" role="tabpanel" data-bs-parent="#accordion-1">
                                <div class="accordion-body">
                                    <p class="mb-0">Yes, you can make changes to your insurance policy. If you need to update your coverage, add additional insured parties, or make any other adjustments, reach out to our customer service team. They will assist you in making the necessary changes to ensure your policy reflects your current needs.</p>
                                </div>
                            </div>
                        </div>
                        <div class="accordion-item">
                            <h2 class="accordion-header" role="tab"><button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#accordion-1 .item-3" aria-expanded="true" aria-controls="accordion-1 .item-3">How can I contact your customer support?</button></h2>
                            <div class="accordion-collapse collapse show item-3" role="tabpanel" data-bs-parent="#accordion-1">
                                <div class="accordion-body">
                                    <p class="mb-0">You can reach our customer support team through phone, email, or by visiting our nearest branch. Our friendly and knowledgeable representatives are ready to assist you with any questions, concerns, or inquiries you may have about your insurance policy.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <footer>
        <div class="container py-4 py-lg-5">
            <div class="row row-cols-2 row-cols-md-4">
                <div class="col-12 col-md-3">
                    <div class="fw-bold d-flex align-items-center mb-2"><span>My Insurance Broker</span></div>
                    <p class="text-muted">We have been a Belgium-based insurance broker since 1998.</p>
                </div>
                <div class="col-sm-4 col-md-3 text-lg-start d-flex flex-column">
                    <h3 class="fs-6 fw-bold">Services</h3>
                    <ul class="list-unstyled">
                        <li><a href="#">Insurance packages</a></li>
                        <li><a href="#">Customer care on first place</a></li>
                        <li><a href="#">Savings</a></li>
                    </ul>
                </div>
                <div class="col-sm-4 col-md-3 text-lg-start d-flex flex-column">
                    <h3 class="fs-6 fw-bold">About</h3>
                    <ul class="list-unstyled">
                        <li><a href="#">Company</a></li>
                        <li><a href="#">Team</a></li>
                        <li><a href="#">Legacy</a></li>
                    </ul>
                </div>
                <div class="col-sm-4 col-md-3 text-lg-start d-flex flex-column">
                    <h3 class="fs-6 fw-bold">Careers</h3>
                    <ul class="list-unstyled">
                        <li><a href="#">Job openings</a></li>
                        <li><a href="#">Employee success</a></li>
                        <li><a href="#">Benefits</a></li>
                    </ul>
                </div>
            </div>
            <hr>
            <div class="text-muted d-flex justify-content-between align-items-center pt-3">
                <p class="mb-0">Copyright © 2023 My Insurance Broker</p>
                <ul class="list-inline mb-0">
                    <li class="list-inline-item"><svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor" viewBox="0 0 16 16" class="bi bi-facebook">
                            <path d="M16 8.049c0-4.446-3.582-8.05-8-8.05C3.58 0-.002 3.603-.002 8.05c0 4.017 2.926 7.347 6.75 7.951v-5.625h-2.03V8.05H6.75V6.275c0-2.017 1.195-3.131 3.022-3.131.876 0 1.791.157 1.791.157v1.98h-1.009c-.993 0-1.303.621-1.303 1.258v1.51h2.218l-.354 2.326H9.25V16c3.824-.604 6.75-3.934 6.75-7.951z"></path>
                        </svg></li>
                    <li class="list-inline-item"><svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor" viewBox="0 0 16 16" class="bi bi-twitter">
                            <path d="M5.026 15c6.038 0 9.341-5.003 9.341-9.334 0-.14 0-.282-.006-.422A6.685 6.685 0 0 0 16 3.542a6.658 6.658 0 0 1-1.889.518 3.301 3.301 0 0 0 1.447-1.817 6.533 6.533 0 0 1-2.087.793A3.286 3.286 0 0 0 7.875 6.03a9.325 9.325 0 0 1-6.767-3.429 3.289 3.289 0 0 0 1.018 4.382A3.323 3.323 0 0 1 .64 6.575v.045a3.288 3.288 0 0 0 2.632 3.218 3.203 3.203 0 0 1-.865.115 3.23 3.23 0 0 1-.614-.057 3.283 3.283 0 0 0 3.067 2.277A6.588 6.588 0 0 1 .78 13.58a6.32 6.32 0 0 1-.78-.045A9.344 9.344 0 0 0 5.026 15z"></path>
                        </svg></li>
                    <li class="list-inline-item"><svg xmlns="http://www.w3.org/2000/svg" width="1em" height="1em" fill="currentColor" viewBox="0 0 16 16" class="bi bi-instagram">
                            <path d="M8 0C5.829 0 5.556.01 4.703.048 3.85.088 3.269.222 2.76.42a3.917 3.917 0 0 0-1.417.923A3.927 3.927 0 0 0 .42 2.76C.222 3.268.087 3.85.048 4.7.01 5.555 0 5.827 0 8.001c0 2.172.01 2.444.048 3.297.04.852.174 1.433.372 1.942.205.526.478.972.923 1.417.444.445.89.719 1.416.923.51.198 1.09.333 1.942.372C5.555 15.99 5.827 16 8 16s2.444-.01 3.298-.048c.851-.04 1.434-.174 1.943-.372a3.916 3.916 0 0 0 1.416-.923c.445-.445.718-.891.923-1.417.197-.509.332-1.09.372-1.942C15.99 10.445 16 10.173 16 8s-.01-2.445-.048-3.299c-.04-.851-.175-1.433-.372-1.941a3.926 3.926 0 0 0-.923-1.417A3.911 3.911 0 0 0 13.24.42c-.51-.198-1.092-.333-1.943-.372C10.443.01 10.172 0 7.998 0h.003zm-.717 1.442h.718c2.136 0 2.389.007 3.232.046.78.035 1.204.166 1.486.275.373.145.64.319.92.599.28.28.453.546.598.92.11.281.24.705.275 1.485.039.843.047 1.096.047 3.231s-.008 2.389-.047 3.232c-.035.78-.166 1.203-.275 1.485a2.47 2.47 0 0 1-.599.919c-.28.28-.546.453-.92.598-.28.11-.704.24-1.485.276-.843.038-1.096.047-3.232.047s-2.39-.009-3.233-.047c-.78-.036-1.203-.166-1.485-.276a2.478 2.478 0 0 1-.92-.598 2.48 2.48 0 0 1-.6-.92c-.109-.281-.24-.705-.275-1.485-.038-.843-.046-1.096-.046-3.233 0-2.136.008-2.388.046-3.231.036-.78.166-1.204.276-1.486.145-.373.319-.64.599-.92.28-.28.546-.453.92-.598.282-.11.705-.24 1.485-.276.738-.034 1.024-.044 2.515-.045v.002zm4.988 1.328a.96.96 0 1 0 0 1.92.96.96 0 0 0 0-1.92zm-4.27 1.122a4.109 4.109 0 1 0 0 8.217 4.109 4.109 0 0 0 0-8.217zm0 1.441a2.667 2.667 0 1 1 0 5.334 2.667 2.667 0 0 1 0-5.334z"></path>
                        </svg></li>
                </ul>
            </div>
        </div>
    </footer>
</template>
<script>
import axios from 'axios';
export default {
  name: 'ContactComponent',
data() {
  return {
    email: '',
    phone: '',
    name: '',
    message: '',
    url: ''
  };
},
methods: {
  subscribe() {
    alert('Thank you for contacting us!');

    console.log(JSON.stringify(this));
    //check environment
    if (process.env.NODE_ENV === 'development') {
      this.url = 'http://localhost:3000/api/v1/new-subscriber';
    } else {
      this.url = 'https://mybrokerservice-ijciww6s2q-ew.a.run.app/api/v1/new-subscriber';
    }
    axios.post(this.url, { name: this.name, email: this.email, message: this.message, phone: this.phone  })
      .then(response => {
        // Handle the success response
        console.log('Subscribed successfully!');
        console.log(response);
        this.email = '';
      })
      .catch(error => {
        // Handle the error response
        console.error('Error subscribing:', error);
      });
  }
}
};
</script>
